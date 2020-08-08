module BadgesHelper
  def localize_rule_subject(rule_subject)
    Badge.human_attribute_name(rule_subject)
  end
end