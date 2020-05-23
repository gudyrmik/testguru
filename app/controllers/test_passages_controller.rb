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
    # А зачем нагромождать? или типа потрениться))
    service = GistQuestionService.new(@test_passage.current_question)
    service_call = service.call

    unless service_call.success?
      new_gist = Gist.create!(user: @test_passage.user, question: @test_passage.current_question, gist_url: service_call[:html_url])
      flash[:notice] = "#{view_context.link_to 'Link', service_call[:url]} #{t('.success')}"
    else flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
