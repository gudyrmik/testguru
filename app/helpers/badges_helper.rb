module BadgesHelper
  def localize_rule(rule)
    Badge.human_attribute_name(rule)
  end
end