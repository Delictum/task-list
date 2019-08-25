class AdminPolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @admin = model
  end

  def index?
    @current_user.present?
  end

  def show?
    @current_user == @admin
  end

  def create?
    @current_user.present?
  end

  def update?
    @current_user == @admin
  end

  def destroy?
    @current_user == @admin
  end
end