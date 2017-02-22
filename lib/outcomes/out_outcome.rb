module Outcomes
  class OutOutcome
    attr_reader :runs_scored
    def initialize
      @runs_scored = 0
    end

    def resultant_team(name, striker, non_striker, yet_to_play_batsmen, out_batsmen, _)
      next_batsman = yet_to_play_batsmen.shift
      Team.new(name, next_batsman, non_striker, yet_to_play_batsmen, out_batsmen << striker)
    end

    def out?
      true
    end
  end
end