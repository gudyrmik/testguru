class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user

  def self.test_by_category(category)
    Test.joins(:category).where("categories.title = #{category}").order(title: :desc)
  end
end
