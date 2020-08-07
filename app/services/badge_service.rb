class BadgeService
  @@rules_en = [ 'Entire category achievement',
              '1st attempt achievement',
              'Hard tests piercer'
            ]
  @@rules_ru = [ 'Целая категория',
              '1я попытка',
              'Жесткие тесты'
            ]

  def self.rules
    case I18n.locale
    when :en
      @@rules_en
    when :ru
      @@rules_ru
    end
  end

  def initialize(test_passage)
    @test_passage = test_passage
  end

# а вот такой не-DRY допустимо или все равно плохо?
# умышленно оставил именно так, хочу понять где эта граница
# идеальный драй превращает код в цепочки методов типа a.b.c.d.e.f.g.h что имхо тоже вредит читабельности
  def assign_badges
    if assign_entire_category_achievement?
      badge = Badge.find_by(rule: @@rules_en[0])
      unless badge == nil
        badge_user = BadgesUser.new(user_id: @test_passage.user.id, badge_id: badge.id)
        badge_user.save!
      end
    end

    if assign_first_attempt_achievement?
      badge = Badge.find_by(rule: @@rules_en[1])
      unless badge == nil
        badge_user = BadgesUser.new(user_id: @test_passage.user.id, badge_id: badge.id)
        badge_user.save!
      end
    end

    if assign_hard_tests_piercer?
      badge = Badge.find_by(rule: @@rules_en[2])
      unless badge == nil
        badge_user = BadgesUser.new(user_id: @test_passage.user.id, badge_id: badge.id)
        badge_user.save!
      end
    end
  end

  private

  def assign_hard_tests_piercer?
    TestPassage.where(user_id: @test_passage.user.id).pluck(:test_id) == Test.where("level > ?", 2).ids
  end

  def assign_first_attempt_achievement?
    TestPassage.where("user_id = ? AND test_id = ?", @test_passage.user.id, @test_passage.test.id).count == 1
  end

  def assign_entire_category_achievement?
    TestPassage.where("user_id = ?", @test_passage.user.id).pluck(:test_id) == Test.where("category_id = ?", @test_passage.test.category_id).ids
  end
end