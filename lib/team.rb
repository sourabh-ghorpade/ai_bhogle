class Team
  def initialize(striker, non_striker, yet_to_play_batsmen, out_batsmen)
    @striker = striker
    @non_striker = non_striker
    @yet_to_play_batsmen = yet_to_play_batsmen
    @out_batsmen = out_batsmen
  end

  def scores
    ([@striker, @non_striker] + @yet_to_play_batsmen + @out_batsmen).map(&:score)
  end

  def size

  end

  def name

  end

  def play(is_last_ball)
    outcome, updated_striker = @striker.play
    return outcome, outcome.resultant_team(updated_striker, @non_striker, @yet_to_play_batsmen, @out_batsmen, is_last_ball)
  end
end