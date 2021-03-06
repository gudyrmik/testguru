class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  def accept!(answer_ids)
    if time_remaining > 0
      self.correct_questions += 1 if correct_answer?(answer_ids)
      self.successful = successful?
      save!
    else
      self.current_question = nil
    end
  end

  def completed?
    self.current_question.nil?
  end

  def successful?
    success_rate >= 85
  end

  def success_rate
    self.correct_questions.fdiv(test.questions.count) * 100
  end

  def question_number
    test.questions.order(:id).where('id <= ?', current_question.id).count
  end

  def time_remaining
    (created_at.to_time + test.duration.minutes - Time.now) / 1.second
  end

  private

  def before_validation_set_current_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count
    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if self.current_question.nil?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end
end
