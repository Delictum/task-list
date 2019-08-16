class TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    true if user.present? && user == task.user
  end

  def destroy?
    true if user.present? && user == task.user
  end

  private

  def task
    record
  end
end