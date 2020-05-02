class QuestionsController < ApplicationController

  before_action :find_question, only: [:show, :destroy, :edit, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def show; end

  def destroy
    @question.destroy
    redirect_to tests_path
  end

  def new
    @question = Question.new
  end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.new(question_params)
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

  def rescue_with_not_found
    render 'shared/_page_not_found'
  end
end