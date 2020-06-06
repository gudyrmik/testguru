class FeedbackController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def create
    FeedbackMailer.feedback(current_user, get_feedback_content).deliver_now
    redirect_to root_path
  end

  private

  def get_feedback_content
    params['feedback_content']
  end

end
