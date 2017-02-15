module Outcomes
  class EvenScoreOutcome
    def initialize(score)
      @score = score
    end

    def resultant_team(batsmen, striker, non_striker, is_last_ball)
      is_last_ball ? Team.new(batsmen, non_striker, striker) : Team.new(batsmen, striker, non_striker)
    end
  end
end