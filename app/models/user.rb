class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins("JOIN histories ON histories.user_id = ? AND tests.id = histories.test_id", id).where("tests.level = ?", level).uniq
  end
end
