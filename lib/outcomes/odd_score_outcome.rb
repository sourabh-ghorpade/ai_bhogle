module Outcomes
  class OddScoreOutcome
    def initialize(score)

    end

    def resultant_team(striker, non_striker, yet_to_play_batsmen, out_batsmen, is_last_ball)
      is_last_ball ? Team.new(striker, non_striker, yet_to_play_batsmen, out_batsmen) :
          Team.new(non_striker, striker, yet_to_play_batsmen, out_batsmen)
    end
  end
end