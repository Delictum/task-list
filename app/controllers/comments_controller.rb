class CommentsController < ApplicationController
  after_action :verify_authorized
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def pundit_user
    if admin_signed_in?
      current_admin
    else
      current_user
    end
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    authorize @comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    authorize @comment
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    authorize @comment
  end

  # GET /comments/1/edit
  def edit
    authorize @comment
  end

  # POST /comments
  # POST /comments.json
  def create
    # @comment = Comment.new(comment_params)
    @comment = Comment.new(params.require(:comment).permit(:comment_text, :author_type, :author_id, :task_id))
    authorize @comment

    if params[:reply_id]
      @comment.reply_id = params[:reply_id]
    end

    if params[:task_id]
      @comment.task_id = params[:task_id]
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    authorize @comment
    respond_to do |format|
      if @comment.update(params.require(:comment).permit(:comment_text, :author_type, :author_id, :task_id))
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    authorize @comment
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {})
    end
end
