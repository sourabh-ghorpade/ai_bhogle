module Outcomes
  class OutOutcome
    def initialize
      @runs_scored = 0
    end

    def resultant_team(all_batsmen, remaining_batsmen, _, non_striker, _)
      next_batsman = remaining_batsmen.shift
      Team.new(all_batsmen, remaining_batsmen, next_batsman, non_striker)
    end
  end
end