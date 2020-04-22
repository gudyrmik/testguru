class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :users, through: :histories, dependent: :destroy

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..9) }
  scope :insane, -> { where(level: 10..Float::INFINITY) }
  scope :tests_by_level, -> (level) { where(level: level) }
  scope :tests_by_category, -> (category) { joins(:category).where(categories: { title: category }).order(title: :desc).pluck(:title) }

  validates :title, presence: :true,
                    uniqueness: { scope: [ :level ] }
  validates :level, numericality: { only_integer: :true, greater_than_or_equal_to: 0 }
end