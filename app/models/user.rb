class User < ApplicationRecord
  has_many :tests, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :tests, through: :histories, dependent: :destroy

  def tests_by_level(level)
    Test.joins(:histories)
      .where(tests: { level: level }, histories: { user_id: id })
      .uniq
  end
end
