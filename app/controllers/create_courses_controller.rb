class CreateCoursesController < ApplicationController
  before_action :set_create_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /create_courses
  # GET /create_courses.json
  def index
    @create_courses = CreateCourse.all
  end

  # GET /create_courses/1
  # GET /create_courses/1.json
  def show
  end

  # GET /create_courses/new
  def new
    @create_course = CreateCourse.new
  end

  # GET /create_courses/1/edit
  def edit
  end

  # POST /create_courses
  # POST /create_courses.json
  def create
    @create_course = CreateCourse.new(create_course_params)

    respond_to do |format|
      if @create_course.save
        format.html { redirect_to @create_course, notice: 'Create course was successfully created.' }
        format.json { render :show, status: :created, location: @create_course }
      else
        format.html { render :new }
        format.json { render json: @create_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /create_courses/1
  # PATCH/PUT /create_courses/1.json
  def update
    respond_to do |format|
      if @create_course.update(create_course_params)
        format.html { redirect_to @create_course, notice: 'Create course was successfully updated.' }
        format.json { render :show, status: :ok, location: @create_course }
      else
        format.html { render :edit }
        format.json { render json: @create_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /create_courses/1
  # DELETE /create_courses/1.json
  def destroy
    @create_course.destroy
    respond_to do |format|
      format.html { redirect_to create_courses_url, notice: 'Create course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_course
      @create_course = CreateCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_course_params
      params.require(:create_course).permit(:name, :description, :privacy, :tags, :objectives)
    end
end
