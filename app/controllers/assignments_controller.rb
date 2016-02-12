class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_filter :load_course
  before_action :authenticate_user!

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = @course.assignments.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = @course.assignments.new
  end

  # GET /assignments/1/edit
  def edit
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
  end

  # POST /assignments
  # POST /assignments.json
  def create
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
     @assignment = @course.assignments.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to [@course, @assignment], notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to [@course, @assignment], notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    if current_user.id!=@course.owner_id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
    end
      return false
    end
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to course_assignments_path(@course), notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @course = Course.find(params[:course_id])
      @assignment = @course.assignments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:name, :description, :attachment, :due_date, :course_id)
    end
end
