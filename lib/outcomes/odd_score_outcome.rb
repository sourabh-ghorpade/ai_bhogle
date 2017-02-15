module Outcomes
  class OddScoreOutcome
    def initialize(score)

    end

    def resultant_team(batsmen, striker, non_striker, is_last_ball)
      is_last_ball ? Team.new(batsmen, striker, non_striker) : Team.new(batsmen, non_striker, striker)
    end
  end
end