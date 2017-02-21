class MatchSimulator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, batting_team)
    @number_of_overs = number_of_overs
    @target = target
    @batting_team = batting_team
    @number_of_balls_left = number_of_overs * BALLS_IN_AN_OVER
  end

  def simulate
    outcomes = play_match
    commentator = Commentator.new(@number_of_overs, @target, outcomes)
    [commentator.result] + @batting_team.scores + commentator.commentary
  end

  private
  def play_match
    @number_of_balls_left.times.inject([]) do |outcomes, ball_number|
      is_last_ball_of_over = (ball_number % BALLS_IN_AN_OVER) == 0

      outcome, @batting_team = @batting_team.play(is_last_ball_of_over)
      outcomes << PlayedBall.new(ball_number, outcome)
    end
  end
end