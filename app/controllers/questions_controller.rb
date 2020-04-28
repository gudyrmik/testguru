class QuestionsController < ApplicationController

  before_action :find_test, only: [:index, :create]
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
    @question.destroy
  end

  def new; end

  def create
    question = @test.questions.create!(question_params)
    render plain: question.body
  end

  private

  def question_params
    params.require(:question).permit(:body)
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