require_relative 'models/player'

class TalentHunterWithNaiveQuery
  TOP_TEAMS = ['ac milan', 'real madrid', 'barcelona']
  SHOOT_ACCURACY = 0.7
  MAX_AGE = 25

  def initialize(options)
    @playing_for_top_team = options.fetch(:playing_for_top_team, true)
    @with_young_age = options.fetch(:with_young_age, true)
    @with_great_accuracy = options.fetch(:with_great_accuracy, true)
  end

  def find_good_forward
    scope = Player

    scope = scope.right_foot

    if @playing_for_top_team
      scope = scope.where('team_name IN (?)', TOP_TEAMS)
    else
      scope = scope.where.not('team_name IN (?)', TOP_TEAMS)
    end

    if @with_great_accuracy
      scope = scope.where('goals / shoots > ?', SHOOT_ACCURACY)
    else
      scope = scope.where.not('goals / shoots > ?', SHOOT_ACCURACY)
    end

    if @with_young_age
      scope = scope.where('YEAR(?) - YEAR(birth_date) < ?', Date.today, MAX_AGE)
    else
      scope = scope.where.not('YEAR(?) - YEAR(birth_date) < ?', Date.today, MAX_AGE)
    end

    scope
  end
end
