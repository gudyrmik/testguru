class FeedbackMailer < ApplicationMailer

  def send_feedback(email, content)
    @email = email
    @content = content
    mail to: Admin.first.email, subjecst: 'Feedback'
  end

end
