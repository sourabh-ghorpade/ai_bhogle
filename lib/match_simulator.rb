class MatchSimulator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, batting_team)
    @number_of_balls_left = number_of_overs * BALLS_IN_AN_OVER
    @batting_team = batting_team
  end

  def simulate
    ScoreCard.new(outcomes)
  end

  private
  def outcomes
    @number_of_balls_left.times.inject([]) do |outcomes, ball_number|
      is_last_ball_of_over = (ball_number % BALLS_IN_AN_OVER) == 0
      outcome, @batting_team = @batting_team.play(is_last_ball_of_over)
      outcomes << outcome
    end
  end
end