class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def pundit_user
    if admin_signed_in?
      current_admin
    else
      current_user
    end
  end

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    authorize @tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = Comment.where(task_id: @task.id)
    authorize @task
  end

  # GET /tasks/new
  def new
    @task = Task.new
    authorize @task
  end

  # GET /tasks/1/edit
  def edit
    authorize @task
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task].permit!)
    authorize @task
    @user = User.find(@task.user_id)

    respond_to do |format|
      if @task.save
        # SendEmailJob.set(wait: 20.seconds).perform_later(@user)
        @user.send_task_created

        format.html { redirect_to @task, notice: 'Task was successfully created. Mail delivered.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)

        @admin = Admin.find(@task.admin_id)
        # SendModifiedTaskEmailJob.set(wait: 20.seconds).perform_later(@admin)
        @admin.send_task_modified

        format.html { redirect_to @task, notice: 'Task was successfully updated.  Mail delivered.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.fetch(:task, {})
    end
end
