class Test < ApplicationRecord
  has_one :category
  has_many :questions
  has_and_belongs_to_many :users

  def self.test_by_category(category)
    joins("JOIN categories ON categories.id = category_id")
      .where(categories: { title: category })
      .order(title: :desc)
      .pluck(:title)
  end
end
