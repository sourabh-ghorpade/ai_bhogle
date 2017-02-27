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

  def play(ball_number)
    played_ball, updated_striker = @striker.play(ball_number)
    resultant_team = played_ball.resultant_team(@name, updated_striker, @non_striker, @yet_to_play_batsmen, @out_batsmen)
    return played_ball, resultant_team
  end

  def scores
    all_batsmen.map(&:score)
  end

  def size
    all_batsmen.count
  end

  def all_out?
    false
  end

  private
  def all_batsmen
    [@striker, @non_striker] + @yet_to_play_batsmen + @out_batsmen
  end
end