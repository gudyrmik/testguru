class FeedbackMailer < ApplicationMailer

  def feedback(user, content)
    @content = content
    mail to: user.email, subject: 'Feedback'
  end

end
