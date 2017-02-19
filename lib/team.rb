class Team
  def initialize(all_batsmen, remaining_batsmen, striker, non_striker)
    @batsmen = all_batsmen
    @remaining_batsmen = remaining_batsmen
    @striker = striker
    @non_striker = non_striker
  end

  def score_card

  end

  def play(is_last_ball)
    outcome = @striker.play
    return outcome, outcome.resultant_team(@batsmen, @remaining_batsmen, @striker, @non_striker, is_last_ball)
  end
end