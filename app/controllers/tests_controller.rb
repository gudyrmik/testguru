class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test, only: :start

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  def index
    @tests = Test.all
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_not_found
    render 'shared/_page_not_found'
  end
end
