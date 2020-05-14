class Admin::QuestionsController < Admin::BaseController

  before_action :find_question, only: [:show, :destroy, :edit, :update]
  before_action :find_test, only: [:new, :create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def show; end

  def destroy
    @question.destroy
    redirect_to admin_test_path(@question.test)
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to admin_question_path(@question)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question)
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

  def find_test
    @test = Test.find(params[:test_id])
  end
end