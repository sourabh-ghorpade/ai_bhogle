module Outcomes
  class OutOutcome
    def initialize
      @runs_scored = 0
    end

    def resultant_team(striker, non_striker, yet_to_play_batsmen, out_batsmen, _)
      next_batsman = yet_to_play_batsmen.shift
      Team.new(next_batsman, non_striker, yet_to_play_batsmen, out_batsmen << striker)
    end
  end
end