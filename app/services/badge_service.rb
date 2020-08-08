class BadgeService
  RULE_SUBJECTS = [:rule_level, :rule_category, :rule_attempt]

  def self.rule_subjects
    RULE_SUBJECTS.map do |rule_subject|
      rule_subject = [rule_subject, RULE_SUBJECTS.find_index(rule_subject)]
    end
  end

  def initialize(test_passage)
    @test_passage = test_passage
  end

  def satisfied_badges
    Badge.select do |badge|
      send("check_#{RULE_SUBJECTS[badge.rule_subject.to_i]}?")
    end
  end

  private

  def check_rule_level?
    TestPassage.where(user_id: @test_passage.user.id).pluck(:test_id) == Test.where("level > ?", @test_passage.test.level).ids
  end

  def check_rule_attempt?
    TestPassage.where("user_id = ? AND test_id = ?", @test_passage.user.id, @test_passage.test.id).count == 1
  end

  def check_rule_category?
    TestPassage.where("user_id = ?", @test_passage.user.id).pluck(:test_id) == Test.where("category_id = ?", @test_passage.test.category_id).ids
  end
end