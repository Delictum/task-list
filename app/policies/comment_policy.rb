class CommentPolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @comment = model
  end

  def index?
    @current_user.present?
  end

  def create?
    if current_user.is_a?(Admin)
      @current_user.present?
    end
  end

  def show?
    @current_user.present?
  end

  def update?
    if current_user.is_a?(Admin)
      @current_user.present?
    else
      @current_user.id == @comment.user_id
    end
  end

  def destroy?
    if current_user.is_a?(Admin)
      @current_user.present?
    else
      @current_user.id == @comment.user_id
    end
  end
end