module Outcomes
  class EvenScoreOutcome
    attr_reader :runs_scored
    def initialize(runs_scored)
      @runs_scored = runs_scored
    end

    def resultant_team(striker, non_striker, yet_to_play_batsmen, out_batsmen, is_last_ball)
      is_last_ball ? Team.new(non_striker, striker, yet_to_play_batsmen, out_batsmen) :
          Team.new(striker, non_striker, yet_to_play_batsmen, out_batsmen)
    end
  end
end