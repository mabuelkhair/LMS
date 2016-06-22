class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def add_question
    question=params[:question]["question"]
    number_of_options =(params[:question]["number_of_options"]).to_i
    answer1=params[:question]["answer1"]
    answer2=params[:question]["answer2"]
    answer3=params[:question]["answer3"]
    answer4=params[:question]["answer4"]
    answer5=params[:question]["answer5"]
    answer6=params[:question]["answer6"]
    answer7=params[:question]["answer7"]
    answer8=params[:question]["answer8"]
    course_id=params[:course_id]
    quiz_id=params[:id]
    weight = params[:question]["weight"]

    course = Course.find(course_id)
    if !(course.nil?) and current_user.id == course.owner.id then
      Question.create(:question => question ,:answer1 => answer1,:answer2 => answer2,:answer3 => answer3,:answer4 => answer4,:answer5 => answer5,:answer6 => answer6,:answer7 => answer7,:answer8 => answer8, :quiz_id => quiz_id,:weight => weight,:number_of_options => number_of_options)
    end
    redirect_to controller: 'quizzes', action: 'edit', course_id: course_id, id: quiz_id
  end

  def update_question
    question_id = params[:question]["id"]
    object = Question.find(question_id)
    object.question=params[:question]["question"]
    object.number_of_options =(params[:question]["number_of_options"]).to_i
    object.answer1=params[:question]["answer1"]
    object.answer2=params[:question]["answer2"]
    object.answer3=params[:question]["answer3"]
    object.answer4=params[:question]["answer4"]
    object.answer5=params[:question]["answer5"]
    object.answer6=params[:question]["answer6"]
    object.answer7=params[:question]["answer7"]
    object.answer8=params[:question]["answer8"]
    course_id=params[:course_id]
    object.quiz_id=params[:id]
    object.weight = params[:question]["weight"]
    course = Course.find(object.quiz.course.id)
    if !(course.nil?) and current_user.id == course.owner.id then
      object.save
    end
    redirect_to controller: 'quizzes', action: 'edit', course_id: course_id, id: object.quiz.id
  end

end
