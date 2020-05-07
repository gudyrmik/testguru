class Test < ApplicationRecord
  has_many :test_passages
  has_many :users, through: :test_passages, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  has_many :questions, dependent: :destroy
  has_many :histories, dependent: :destroy

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..9) }
  scope :insane, -> { where(level: 10..Float::INFINITY) }
  scope :tests_by_level, -> (level) { where(level: level) }
  scope :tests_by_category, -> (category) { joins(:category).where(categories: { title: category }).order(title: :desc).pluck(:title) }

  validates :title, presence: :true, uniqueness: { scope: :level }
  validates :level, numericality: { greater_than_or_equal_to: 0 }
end