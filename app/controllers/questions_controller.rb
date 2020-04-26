class QuestionsController < ApplicationController

  before_action :find_test, only: :index
  before_action :find_question, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    result = @test.questions.all.pluck(:body)
    render plain: result
  end

  def show
    render plain: @question.body
  end

  def destroy
    Question.destroy(@question)
  end

  def new; end
  #render inline: '<%= console %>'

  def create
    question = Question.create!(question_params)
    render plain: question.body
  end

  private

  def question_params
    test_id_param = params.permit(:test_id)
    params.require(:question).permit(:body).merge(test_id_param)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_not_found
    render plain: 'Not found'
  end
end