class StaticPagesController < ApplicationController
  def home
  end

  def index
  end

  def about
  end

  def dashboard
    @tasks = Task.all
    @tasks_review = Task.where(admin_id: current_admin.id, status: 2)

    @search = params["search"]
    if @search.present?

      @subject = @search["subject"]
      @status = @search["status"]
      @type = @search["type"]
      @assignee = @search["assignee"]
      @created_by = @search["created_by"]

      @tasks = Task.where("subject ILIKE ?", "%#{@subject}%")
      unless @status.to_s.empty?
        @tasks = @tasks.where(status: @status)
      end

      unless @type.to_s.empty?
        @tasks = @tasks.where(type: @type)
      end

      unless @user.to_s.empty?
        @tasks = @tasks.where(user_id: @user)
      end

      unless @assignee.to_s.empty?
        @tasks = @tasks.where(user_id: @assignee)
      end

      unless @created_by.to_s.empty?
        @tasks = @tasks.where(admin_id: @created_by)
      end
    end
  end
end
