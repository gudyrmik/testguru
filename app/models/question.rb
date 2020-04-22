class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :body, presence: :true
  validate :validate_max_answers, on: [ :create, :update ]

  private

  def validate_max_answers
    answers_num = answers.size
    errors.add(:invalid_levels, message: 'Invalid number of levels') if answers_num > 4
  end
end
