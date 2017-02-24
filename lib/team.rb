class Team
  attr_reader :name
  BALLS_IN_AN_OVER = 6

  def initialize(name, striker, non_striker, yet_to_play_batsmen, out_batsmen)
    @name = name
    @striker = striker
    @non_striker = non_striker
    @yet_to_play_batsmen = yet_to_play_batsmen
    @out_batsmen = out_batsmen
  end

  def play(over_number, played_balls = [])
    if played_balls.count == BALLS_IN_AN_OVER
      return PlayedOver.new(over_number, played_balls), self
    else
      played_ball, updated_striker = @striker.play(played_balls.count + 1)
      played_team = played_ball.resultant_team(@name, updated_striker, @non_striker, @yet_to_play_batsmen, @out_batsmen)
      played_team.play(over_number, played_balls + [played_ball])
    end
  end

  def scores
    all_batsmen.map(&:score)
  end

  def size
    all_batsmen.count
  end

  private
  def all_batsmen
    [@striker, @non_striker] + @yet_to_play_batsmen + @out_batsmen
  end
end