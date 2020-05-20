class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: [:show, :update, :result, :gist]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      redirect_to result_test_passage_path
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    flash_options = unless result.nil? #не знаю что там чекать, огромный хэщ, а задача в целом сугубо учебная, пусть будет просто не нил:D
      { notice: "#{view_context.link_to 'Link', result[:url]} #{t('.success')}" }
    else
      { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
