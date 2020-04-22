class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validate :answers_per_question, on: :create

  def answers_per_question
    answers_num = Question.find(question_id).answers.size
    errors.add(:answers_max_exceeded, message: 'Question can\'t contain more than 4 answers.') if answers_num > 4
  end
end
