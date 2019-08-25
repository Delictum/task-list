class StoriesController < ApplicationController
  after_action :verify_authorized
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def pundit_user
    if admin_signed_in?
      current_admin
    else
      current_user
    end
  end

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
    authorize @stories
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    authorize @story
  end

  # GET /stories/new
  def new
    @story = Story.new
    authorize @story
  end

  # GET /stories/1/edit
  def edit
    authorize @story
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(params[:story].permit!)
    authorize @story

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    authorize @story
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    authorize @story
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.fetch(:story, {})
    end
end