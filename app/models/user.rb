class User < ApplicationRecord
  has_many :created_tests, dependent: :destroy, foreign_key: 'user_id', class_name: 'Test'
  has_many :histories, dependent: :destroy
  has_many :tests, through: :histories, dependent: :destroy

  validates :email, presence: :true,
                    uniqueness: :true

  def tests_by_level(level)
    created_tests.where( { level: level } )
  end
end
