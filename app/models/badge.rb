class Badge < ApplicationRecord
  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users, dependent: :destroy

  validates :title, :image_url, presence: :true

  # ради того чтобы работала вот эта валидация я сделал константу BadgeService::RULE_SUBJECTS[] строками вместо символов
  # потому как из badge_params приходит хэш с строками. вопрос - как по человечески сделать, ну чтобы с символами работало?
  # приходит на ум тут в валидации { in: BadgeService::RULE_SUBJECTS.map(&:to_s) } но чую это не правильно
  validates :rule_subject, uniqueness: { scope: :rule_objective }, inclusion: { in: BadgeService::RULE_SUBJECTS, message: "Badge service doesn't recognize given rule subject." }
end
