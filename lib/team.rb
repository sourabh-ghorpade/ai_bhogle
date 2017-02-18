class Team
  def initialize(batsmen, striker = batsmen[0], non_striker = batsmen[1])
    @batsmen = batsmen - [striker, non_striker]
    @striker = striker
    @non_striker = non_striker
  end

  def score_card

  end

  def play(is_last_ball)
    outcome = @striker.play
    return outcome, outcome.resultant_team(@batsmen, @striker, @non_striker, is_last_ball)
  end
end