class QuestionsController < ApplicationController

  before_action :find_test

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    result = @test.questions.all.pluck(:body)
    render plain: result
  end

  def show
    render inline: '<%= console %>'
    result = Question.find(params[:id]).body
    #render plain: result
  end

  def destroy
    Question.destroy(params.permit(:id))
  end

  def new
    #render inline: '<%= console %>'
  end

  def create
    question = Question.create!(params.permit(:body, :test_id))
    render plain: question.body
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_not_found
    render plain: 'Not found'
  end
end