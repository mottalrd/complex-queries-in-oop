require_relative 'models/interesting_player'

class TalentHunterWithQueryObject
  def initialize(options)
    @playing_for_top_team = options.fetch(:playing_for_top_team, true)
    @with_young_age = options.fetch(:with_young_age, true)
    @with_great_accuracy = options.fetch(:with_great_accuracy, true)
  end

  def find_good_forward
    search  = InterestingPlayer.new

    search = search.right_foot
    search = @playing_for_top_team ? search.playing_for_big_team : search.not_playing_for_big_team
    search = @with_great_accuracy ? search.with_great_shoot_accuracy : search.without_great_shoot_accuracy
    search = @with_young_age ? search.young : search.old

    search
  end
end
