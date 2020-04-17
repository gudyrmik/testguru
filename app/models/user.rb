class User < ApplicationRecord
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def testsByLevel(level)
    user_id = User.select(:id).find_by(name: @name).id
    Test.where(id: History.select(:test_id).where(user_id: user_id).ids).where(level: level)
  end
end
