class Test < ApplicationRecord
  def self.testByCategory(category)
    category_id = Category.find_by(title: category).id
    Test.where(id: category_id).order('title DESC')
  end
end
