class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: [:show, :update, :result, :gist]
  before_action :set_badge_service, only: :result

  def show; end

  def result
    @test_passage.save! # saves all completed test attempts
    current_user.badges << @badge_service.satisfied_badges
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      redirect_to result_test_passage_path
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    service_call_result = service.call

    unless service.success?(service_call_result)
      new_gist = Gist.create!(user: @test_passage.user, question: @test_passage.current_question, gist_url: service_call_result[:html_url])
      flash[:notice] = "#{view_context.link_to 'Link', service_call_result[:url]} #{t('.success')}"
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def set_badge_service
    @badge_service = BadgeService.new(@test_passage)
  end
end
