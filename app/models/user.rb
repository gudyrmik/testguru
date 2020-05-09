class User < ApplicationRecord

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, dependent: :destroy, foreign_key: 'user_id', class_name: 'Test'
  has_many :histories, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  def tests_by_level(level)
    created_tests.where( { level: level } )
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

end
