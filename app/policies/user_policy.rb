class UserPolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    if current_user.is_a?(Admin)
      @current_user.present?
    end
  end

  def show?
    if current_user.is_a?(Admin)
      @current_user.present?
    else
      @current_user == @user
    end
  end

  def update?
    if current_user.is_a?(Admin)
      @current_user.present?
    else
      @current_user == @user
    end
  end

  def destroy?
    if current_user.is_a?(Admin)
      @current_user.present?
    else
      @current_user == @user
    end
  end
end