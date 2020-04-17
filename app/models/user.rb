class User < ApplicationRecord
  has_many :tests

  def testsByLevel(level)
    Test.joins(:user).where("level = #{level} AND user_id = #{id}")
  end
end
