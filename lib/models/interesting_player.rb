require_relative 'player'

class InterestingPlayer
  TOP_TEAMS = ['ac milan', 'real madrid', 'barcelona']
  SHOOT_ACCURACY = 0.7
  MAX_AGE = 25

  attr_reader :scope

  def initialize(scope = Player)
    @scope = scope
  end

  def playing_for_big_team
    self.class.new @scope.where('team_name IN (?)', TOP_TEAMS)
  end

  def not_playing_for_big_team
    self.class.new @scope.where.not('team_name IN (?)', TOP_TEAMS)
  end

  def with_great_shoot_accuracy
    self.class.new @scope.where('goals / shoots > ?', SHOOT_ACCURACY)
  end

  def without_great_shoot_accuracy
    self.class.new @scope.where.not('goals / shoots > ?', SHOOT_ACCURACY)
  end

  def young
    self.class.new @scope.where('YEAR(?) - YEAR(birth_date) < ?', Date.today, MAX_AGE)
  end

  def old
    self.class.new @scope.where.not('YEAR(?) - YEAR(birth_date) < ?', Date.today, MAX_AGE)
  end

  def method_missing(method, *args, &block)
    result = @scope.send(method, *args, &block)

    is_a_relation?(result) ? self.class.new(result) : result
  end

  def respond_to?(method, include_private = false)
    super || @scope.respond_to?(method, include_private)
  end

  private

  def is_a_relation?(obj)
    obj.instance_of? relation_class_name
  end

  def relation_class_name
    "#{@scope.name}::ActiveRecord_Relation".constantize
  end
end
