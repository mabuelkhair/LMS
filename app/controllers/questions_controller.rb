class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def add_question
    question=params[:question]["question"]
    number_of_options =[:question]["number_of_options"] 
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
      Question.create(:question => question ,:answer1 => answer1,:answer2 => answer2,:answer3 => answer3
      ,:answer4 => answer4,:answer5 => answer5,:answer1 => answer6,:answer7 => answer7,:answer8 => answer8
       , :quiz_id => quiz_id,:weight => weight,:number_of_options => number_of_options)
    end
    redirect_to controller: 'quizzes', action: 'edit', course_id: course_id, id: quiz_id
  end

  def update_question
    question_id = params[:true_false_question]["id"]
    object = TrueFalseQuestion.find(question_id)
    object.question=params[:true_false_question]["question"]
    object.answer=params[:true_false_question]["answer"]
    object.question_weight = params[:true_false_question]["question_weight"]
    course = Course.find(object.quiz.course.id)
    if !(course.nil?) and current_user.id == course.owner.id then
      object.save
    end
    redirect_to controller: 'true_false_quizzes', action: 'edit', course_id: object.quiz.course.id, id: object.quiz.id
  end

end
