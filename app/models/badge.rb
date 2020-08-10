class Badge < ApplicationRecord
  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users, dependent: :destroy

  validates :title, :image_url, presence: :true
  validates_uniqueness_of :title, scope: [:rule_subject, :rule_objective]
  validate :rule_service_integrity, on: :create

  def rule_service_integrity
    unless BadgeService::RULE_SUBJECTS.include?(self.rule_subject.to_sym)
      errors.add(:rule_unknown, message: "Badge service doesn't recognize given rule subject: #{self.rule_subject}")
    end
  end
end
