class TestsController < ApplicationController

  before_action :find_all_tests, only: :index
  before_action :find_test, only: [:show, :edit, :update, :destroy]
  before_action :find_questions, only: :show

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index; end

  def show; end

  def edit; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_all_tests
    @tests = Test.all
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_not_found
    render 'shared/_page_not_found'
  end

  def find_questions
    @questions = Question.where(test_id: params[:id])
  end
end
