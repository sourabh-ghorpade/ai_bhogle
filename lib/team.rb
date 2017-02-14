class Team
  def initialize(batsmen, striker = batsmen[0], non_striker = batsmen[1])
    @batsmen = batsmen
    @striker = striker
    @non_striker = non_striker
  end

  def play(is_last_ball)
    outcome = @striker.play
    if outcome.out?
      updated_team = Team.new(@batsmen, @batsmen[2], @non_striker)
    else
      if outcome.strike_change?
        if is_last_ball
          updated_team = self
        else
          updated_team = Team.new(@batsmen, @non_striker, @striker)
        end
      else
        if is_last_ball
          updated_team = Team.new(@batsmen, @non_striker, @striker)
        else
          updated_team = self
        end
      end
    end
    return outcome, updated_team
  end
end