class User < ApplicationRecord
  has_and_belongs_to_many :tests
  def tests_by_level(level)
    Test.joins("JOIN histories ON tests.id = histories.test_id")
      .where(tests: { level: level }, histories: { user_id: id })
      .uniq
  end
end
