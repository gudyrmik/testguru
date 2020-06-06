class Feedback
  include ActiveModel::Model

  attr_accessor :email, :content

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true

  def send_mail
    FeedbackMailer.send_feedback(self.email, self.content).deliver_now
  end
end