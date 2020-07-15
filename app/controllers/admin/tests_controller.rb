class Admin::TestsController < Admin::BaseController

  before_action :find_test, only: [:show, :edit, :update, :destroy, :update_inline]
  before_action :set_tests, only: [:index, :update_inline]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    @gists = Gist.where(user: current_user)
  end

  def show; end

  def edit; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.tests.new(test_params)

    if @test.save
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :duration)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def set_tests
    @tests = Test.all
  end

  def rescue_with_not_found
    render 'shared/_page_not_found'
  end
end
