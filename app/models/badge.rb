class Badge < ApplicationRecord
  belongs_to :user
  belongs_to :badge_type

  def type
    self.badge_type.title
  end
end
