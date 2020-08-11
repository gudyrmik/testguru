class Badge < ApplicationRecord
  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users, dependent: :destroy

  validates :title, :image_url, presence: :true
  validates :rule_subject, uniqueness: { scope: :rule_objective }, inclusion: { in: BadgeService::RULE_SUBJECTS, message: "Badge service doesn't recognize given rule subject." }
end
