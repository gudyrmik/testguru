class Test < ApplicationRecord
  def self.test_by_category(category)
    joins("JOIN categories ON categories.id = category_id").where("categories.title = ?", category).order(title: 
:desc).pluck(:title)
  end
end
