class BadgeService
  RULE_SUBJECTS = %w[rule_level rule_category rule_attempt].freeze

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
    return false unless objective_level == @test_passage.test.level
    
    last_badge_created_at = find_last_badge_time(badge.rule_subject)
    applicable_test_passages = find_test_passages(last_badge_created_at)
    applicable_test_passages.pluck(:test_id).uniq == Test.where("level = ?", objective_level).ids
  end

  def check_rule_attempt?(badge)
    last_badge_created_at = find_last_badge_time(badge.rule_subject)
    applicable_test_passages = find_test_passages(last_badge_created_at)
    applicable_test_passages.pluck(:test_id).count == badge.rule_objective.to_i
  end

  def check_rule_category?(badge)
    category = Category.find_by("title = ?", badge.rule_objective.to_s)
    return false if category.nil? || @test_passage.test.category_id != category.id

    last_badge_created_at = find_last_badge_time(badge.rule_subject)
    applicable_test_passages = find_test_passages(last_badge_created_at)
    applicable_test_passages.pluck(:test_id) == Test.where("category_id = ?", category.id).ids
  end

  def find_test_passages(creation_time)
    @user.test_passages.where("successful = ? AND created_at > ?", true, creation_time)
  end

  def find_last_badge_time(rule_subject)
    badge = @user.badges.where(rule_subject: rule_subject)
    return Time.new(0) if badge.nil?
    @user.badges_users.where(badge_id: badge.id).order(:created_at).last.created_at
  end
end