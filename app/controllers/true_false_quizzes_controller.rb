class TrueFalseQuizzesController < ApplicationController
  before_action :set_true_false_quiz, only: [:show, :edit, :update, :destroy,:solve]
  before_action :load_course
  before_action :authenticate_user!

  def solve
  end

  def solve_quiz
    puts "**************************"
    puts params[:user_solutions].first
  end 
  # GET /true_false_quizzes
  # GET /true_false_quizzes.json
  def index
    @true_false_quizzes = @course.quizzes.all
  end

  # GET /true_false_quizzes/1
  # GET /true_false_quizzes/1.json
  def show
  end

  # GET /true_false_quizzes/new
  def new
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    @course = Course.find(params[:course_id])
    @true_false_quiz =  @course.quizzes.new
  end

  # GET /true_false_quizzes/1/edit
  def edit
    # @true_false_question=@true_false_quiz.questions.new
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
  end

  # POST /true_false_quizzes
  # POST /true_false_quizzes.json
  def create
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    @true_false_quiz =  @course.quizzes.new(true_false_quiz_params)

    respond_to do |format|
      if @true_false_quiz.save
        format.html { redirect_to [@course,@true_false_quiz], notice: 'True false quiz was successfully created.' }
        format.json { render :show, status: :created, location: @true_false_quiz }
      else
        format.html { render :new }
        format.json { render json: @true_false_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /true_false_quizzes/1
  # PATCH/PUT /true_false_quizzes/1.json
  def update
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    respond_to do |format|
      if @true_false_quiz.update(true_false_quiz_params)
        format.html { redirect_to [@course,@true_false_quiz], notice: 'True false quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @true_false_quiz }
      else
        format.html { render :edit }
        format.json { render json: @true_false_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /true_false_quizzes/1
  # DELETE /true_false_quizzes/1.json
  def destroy
    if current_user.id!=@course.owner.id
      respond_to do |format|
        format.html { redirect_to :action => 'index' ,:controller=>"courses", notice: 'You are Not Authorized' }
      end
      return false
    end
    @true_false_quiz.destroy
    respond_to do |format|
      format.html { redirect_to course_true_false_quizzes_path(@course), notice: 'True false quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_true_false_quiz

      @course = Course.find(params[:course_id])
      @true_false_quiz =  @course.quizzes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def true_false_quiz_params
         params.require(:true_false_quiz).permit(:name)
   
    end

    def load_course
      @course = Course.find(params[:course_id])
    end
end

