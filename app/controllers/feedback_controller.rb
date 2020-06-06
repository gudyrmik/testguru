class FeedbackController < ApplicationController

  def index
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new({ email: get_email, content: get_content })
    if @feedback.valid?
      @feedback.send_mail
      flash[:notice] = 'Feedback successfully sent'
    else
      flash[:alert] = 'Feedback cant be sent'
    end
    redirect_to root_path
  end

  private

  def get_email
    params[:email]
  end

  def get_content
    params[:content]
  end

end
