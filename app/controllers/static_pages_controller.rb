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

    users_result = Task.connection.select_all('SELECT result_done.user_id AS id FROM (
    SELECT user_id, COUNT(status) AS count_done
    FROM tasks
    GROUP BY user_id, status
	  HAVING status = 3) AS result_done
	  JOIN (
	  SELECT user_id, count_not_done FROM (
    SELECT user_id, COUNT(status) AS count_not_done
    FROM tasks
    GROUP BY user_id, status
	  HAVING status < 3) AS result_done) AS result_not_done
	  ON result_done.user_id=result_not_done.user_id WHERE count_done > count_not_done;')
    users_result_array = []
    users_result.each do |row|
      users_result_array << row['id']
    end
    @users = User.where(id: users_result_array)

    admins_result = Task.connection.select_all('SELECT admin_id AS id FROM (
    SELECT admin_id, user_id, COUNT(status) AS count_status
    FROM tasks
    GROUP BY user_id, status, admin_id
	  HAVING status = 1) AS result_table
	  WHERE count_status > 1;')
    admins_result_array = []
    admins_result.each do |row|
      admins_result_array << row['id']
    end
    @admins = User.where(id: admins_result_array)

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
