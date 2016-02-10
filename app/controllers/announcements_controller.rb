class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_filter :load_course
  before_action :authenticate_user!



  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = @course.announcements.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = @course.announcements.new
  end

  # GET /announcements/1/edit
  def edit
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
  end

  # POST /announcements
  # POST /announcements.json
  def create
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
    @announcement = @course.announcements.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to course_announcements_path(@course), notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to course_announcements_path(@course), notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to course_announcements_path(@course), notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
       @course = Course.find(params[:course_id])
      @announcement = @course.announcements.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :body)
    end
end
