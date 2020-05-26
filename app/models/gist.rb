class Gist < ApplicationRecord

  validates :gist_url, presence: true

  belongs_to :user
  belongs_to :question

end