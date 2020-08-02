class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question
  before_validation :before_validation_set_completed_test_passages

  def accept!(answer_ids)
    if time_remaining > 0
      self.correct_questions += 1 if correct_answer?(answer_ids)
      save!
    else
      self.current_question = nil
    end
  end

  def completed?
    self.current_question.nil?
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

  def assign_badges
    if assign_hard_tests_piercer?
      badge = self.user.badges.new(title: 'Hard tests piercer', badge_type_id: 1)
      badge.save!
    end

    if assign_first_attempt_achievement?
      badge = self.user.badges.new(title: '1st attempt achievement', badge_type_id: 2)
      badge.save!
    end

    if assign_entire_category_achievement?
      badge = self.user.badges.new(title: 'Entire category achievement', badge_type_id: 3)
      badge.save!
    end
  end

  private

  def before_validation_set_current_question
    self.current_question = next_question
  end

  def before_validation_set_completed_test_passages
    @test_passages = TestPassage.all
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

  def assign_hard_tests_piercer?
    TestPassage.where(user_id: self.user.id).pluck(:test_id) == Test.where("level > ?", 2).ids
  end

  def assign_first_attempt_achievement?
    TestPassage.where("user_id = ? AND test_id = ?", self.user.id, self.test.id).count == 1
  end

  def assign_entire_category_achievement?
    TestPassage.where("user_id = ?", self.user.id).pluck(:test_id) == Test.where("category_id = ?", self.test.category_id).ids
  end
end
