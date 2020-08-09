module BadgesHelper
  def badges_rules
    BadgeService::RULE_SUBJECTS.map { |rule_subject| [t("badges.rules.#{rule_subject}"), rule_subject] }
  end
end