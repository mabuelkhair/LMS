class SolutionsController < ApplicationController
  before_filter :load_course ,:except => [:set_grade]
  # skip_before_filter :set_grade

  before_action :authenticate_user!

  def delete_solution
    Solution.where(:student_id => current_user.id,:course_id => params[:course_id],:assignment_id => params[:assignment_id]).destroy_all
    @course = Course.find(params[:course_id])
    redirect_to :back
  end
  def set_grade
    @solution=Solution.find(params[:id])
    @course=@solution.assignment.course
    if @course.owner_id == current_user.id then
      @solution.update(solution_params)
      redirect_to :back
    else
      redirect_to(:controller => 'courses' ,:action => 'show')

    end
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

    private
    def load_course
      @course = Course.find(params[:course_id])
      @assignment = @course.assignments.find(params[:assignment_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:attachment, :student_id, :course_id,:assignment_id,:grade)
    end

end
