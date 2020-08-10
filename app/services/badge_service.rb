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
    objective_level = badge.rule_objective.to_i
    if objective_level == @test_passage.test.level
      applicable_est_passages = filter_test_passages(badge)
      if applicable_test_passages.pluck(:test_id).uniq == Test.where("level = ?", objective_level).ids
        applicable_test_passages.badge_assigned = badge.rule_subject
        applicable_test_passages.save!
        true
      else
        false
      end
    end
  end

  def check_rule_attempt?(badge)
    applicable_test_passages = filter_test_passages(badge)
    if applicable_test_passages.pluck(:test_id).count == badge.rule_objective.to_i
      applicable_test_passages.badge_assigned = badge.rule_subject
      applicable_test_passages.save!
      true
    else
      false
    end
  end

  def check_rule_category?(badge)
    category = Category.find_by("title = ?", badge.rule_objective.to_s)
    if !category.nil? && @test_passage.test.category_id == category.id
      applicable_test_passages = filter_test_passages(badge)
      if applicable_test_passages.pluck(:test_id) == Test.where("category_id = ?", category.id).ids
        applicable_test_passages.badge_assigned = badge.rule_subject
        applicable_test_passages.save!
        true
      else
        false
      end
    end
  end

  def filter_test_passages(badge)
    @user.test_passages.where("successful = ? AND badge_assigned != ?", true, badge.rule_subject)
  end
end