class CommentPolicy < ApplicationPolicy
  def create?
     user.present?
  end

  def destroy?
    can_moderate?(user, record)
  end
end