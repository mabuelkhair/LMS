class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_filter :load_course
  before_action :authenticate_user!

  def delete_solution
    Solution.where(:student_id => current_user.id,:course_id => params[:course_id],:assignment_id => params[:assignment_id]).destroy_all
    format.html { redirect_to course_assignments_path(@course), notice: 'Submition was deleted successfully.' }
      
  end

  def index
  	@solutions = @assignment.solutions.all
  end

  def new
  	@solution = @assignment.solutions.new
  end

  def create
     @solution = @assignment.solutions.new(solution_params)
     @solution.student_id = current_user.id
     @solution.course_id = params[:course_id]
    respond_to do |format|
      if @solution.save
        format.html { redirect_to course_assignments_path(@course), notice: 'solution was submitted Created.' }
      
        # #format.html { redirect_to [@course, @assignment], notice: 'Assignment was successfully created.' }
        # format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

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
      @assignment = @course.assignments.find(params[:assignment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @course = Course.find(params[:course_id])
      @assignment = @course.assignments.find(params[:assignment_id])
      @solution = @assignment.solution.where(:student_id => current_user.id).first 

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:attachment, :student_id, :course_id,:assignment_id)
    end

end
