class Team
  def initialize(batsmen)
    @batsmen = batsmen
    @striker = @batsmen[0]
    @non_striker = @batsmen[1]
  end

  def play(is_last_ball)
    outcome = @striker.play
    @striker = outcome.next_striker(@striker, @non_striker, @batsmen, is_last_ball)
    outcome
  end
end