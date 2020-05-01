class QuestionsController < ApplicationController

  before_action :find_question, only: [:show, :destroy, :edit, :update]
  before_action :find_questions, only: :index
  before_action :find_test, only: :new

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    redirect_to test_path(params[:test_id])
  end

  def show; end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@question[:test_id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question[:test_id] = params[:test_id] # наверное это жесть как коряво, но я чот в ступоре ;(, как этот тест-айди сквозь форму записать?
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def find_questions
    @questions = Question.where(test_id: params[:test_id])
  end

  def rescue_with_not_found
    render 'shared/_page_not_found'
  end

  def find_test
    @test = Test.find(params[:test_id])
  end
end