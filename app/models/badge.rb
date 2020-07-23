class Badge < ApplicationRecord
  belongs_to :user
  belongs_to :badge_type
end
