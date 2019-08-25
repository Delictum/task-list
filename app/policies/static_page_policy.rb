class StaticPagePolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :model

  def dashboard
    if current_user.is_a?(Admin)
      @current_user.present?
    end
  end
end