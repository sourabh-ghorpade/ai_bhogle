class OutOutcome
  def initialize
    @runs_scored = 0
  end

  def resultant_team(remaining_batsmen, _, non_striker, _)
    next_batsman = remaining_batsmen.shift
    Team.new(remaining_batsmen, next_batsman, non_striker)
  end
end