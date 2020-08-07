class BadgeService
  RULES = [:rule_hard_tests, :rule_ruby_category, :rule_first_attempt]

  def self.rules
    localized_rules = []
    RULES.each { |rule| localized_rules << [ApplicationController.helpers.localize_rule(rule), RULES.find_index(rule)] }
    localized_rules
  end

  def initialize(test_passage)
    @test_passage = test_passage
  end

  def satisfied_badges
    Badge.select do |badge|
      send("check_#{RULES[badge.rule.to_i]}?")
    end
  end

  private

  def check_rule_hard_tests?
    TestPassage.where(user_id: @test_passage.user.id).pluck(:test_id) == Test.where("level > ?", 2).ids
  end

  def check_rule_first_attempt?
    TestPassage.where("user_id = ? AND test_id = ?", @test_passage.user.id, @test_passage.test.id).count == 1
  end

  def check_rule_ruby_category?
    TestPassage.where("user_id = ?", @test_passage.user.id).pluck(:test_id) == Test.where("category_id = ?", 1).ids
  end
end