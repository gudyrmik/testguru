class BadgeType < ApplicationRecord
  has_many :badges, dependent: :destroy
end
