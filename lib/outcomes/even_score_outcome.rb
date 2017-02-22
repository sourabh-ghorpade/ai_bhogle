module Outcomes
  class EvenScoreOutcome
    attr_reader :runs_scored

    def initialize(runs_scored)
      @runs_scored = runs_scored
    end

    def resultant_team(name, striker, non_striker, yet_to_play_batsmen, out_batsmen, is_last_ball)
      is_last_ball ? Team.new(name, non_striker, striker, yet_to_play_batsmen, out_batsmen) :
          Team.new(name, striker, non_striker, yet_to_play_batsmen, out_batsmen)
    end

    def out?
      false
    end
  end
end