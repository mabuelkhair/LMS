class CoursesController < ApplicationController
  before_action :set_course, only: [:reject_request,:accept_request,:show, :edit, :update, :destroy,:join_course,:join_request,:join_requests]
  # before_action :authenticate_user!

  def related_courses
    filed_of_intrests = @course.tags.split(/,/)
    filed_of_intrests=filed_of_intrests.map!(&:downcase)
    @selected = []
    courses=Course.all
    courses.each do |course|
      course_interests=course.tags.split(/,/)
      if course.id!= @course.id
        course_interests.each do |tg|
          if  filed_of_intrests.include? tg.downcase then
                 @selected << course
                 break
          end
        end
      end
    end
    @selected.shuffle
  end
  helper_method :related_courses

  def join_course
    authenticate_user!
    
    redirect_to(:action => 'show')

    if @course.privacy=="public" then
      if  !(@course.students.include? current_user or @course.owner.id==current_user.id) then
        @course.students << current_user

        fields_of_interest = @course.tags.split(/,/)
        fields_of_interest.each do |tag|
          current_user.interests.create(name: tag)  
        end

      end
    end
  end

  def join_requests
    authenticate_user!
    if current_user.id==@course.owner.id then
      @requests = JoinRequest.where(:course_id => @course.id )
      @requesters = Hash.new
      @requests.each  do |request|
        user = User.find(request.requester_id)
        @requesters[user.id]=user.email
      end
    end
  end

  def join_request
    authenticate_user!
    redirect_to(:action => 'show')
    if @course.privacy=="private" then
      if !(@course.students.include? current_user or @course.owner.id==current_user.id) then
        if JoinRequest.where(:course_id => @course.id , :requester_id => current_user.id).count==0 then
          JoinRequest.create(:course_id => @course.id , :requester_id => current_user.id)
        end
      end
    end
  end

  def accept_request
    authenticate_user!
    redirect_to(:action => 'join_requests')
    if current_user.id == @course.owner_id
     req_id=params[:requester_id]

     requester = User.find(req_id)
     @course.students << requester

     fields_of_interest = @course.tags.split(/,/)
        fields_of_interest.each do |tag|
          requester.interests.create(name: tag)  
      end
      
     JoinRequest.where(:course_id =>@course.id,:requester_id => req_id).destroy_all
   end
  end

  def reject_request
    authenticate_user!
    redirect_to(:action => 'join_requests')
    if current_user.id == @course.owner_id
     req_id=params[:requester_id]
     JoinRequest.where(:course_id =>@course.id,:requester_id => req_id).destroy_all
   end
  end

  def studying
    authenticate_user!
    @courses=current_user.courses
  end

  def mycourses
    authenticate_user!
    @courses =Course.where("owner_id = ?", current_user.id);
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    # authenticate_user!
  end

  # GET /courses/new
  def new
    authenticate_user!
    @course= Course.new
  end

  # GET /courses/1/edit
  def edit
    authenticate_user!
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    authenticate_user!
    @course= Course.new(course_params)
    @course.owner_id=current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Create course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    authenticate_user!
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Create course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authenticate_user!
        if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Create course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :privacy, :tags, :objectives,:owner_id, :prerequisites,:avatar)
    end
end
