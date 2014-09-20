class CommentsController < ApplicationController
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit( :body))
    @comment.post = @post
    authorize @comment
    if @comment.save
       redirect_to [@topic, @post], notice: "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
     @topic = Topic.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@topic, @post]
     end
   end

  
end
