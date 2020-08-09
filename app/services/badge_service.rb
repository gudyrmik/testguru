class BadgeService
  RULE_SUBJECTS = [:rule_level, :rule_category, :rule_attempt]

  def initialize(test_passage)
    @user = test_passage.user
    @test_passage = test_passage
  end

  def satisfied_badges
    Badge.select do |badge|
      send("check_#{badge.rule_subject}?", badge)
    end
  end

  private

  def check_rule_level?(badge)
    @user.test_passages.pluck(:test_id) == Test.where("level = ?", badge.rule_objective.to_i).ids
  end

  def check_rule_attempt?(badge)
    @user.test_passages.where(successful: true).pluck(:test_id).count == badge.rule_objective.to_i
  end

  def check_rule_category?(badge)
    category = Category.find_by("title = ?", badge.rule_objective.to_s)
    @user.test_passages.pluck(:test_id) == Test.where("category_id = ?", category.id).ids unless category.nil?
  end
end