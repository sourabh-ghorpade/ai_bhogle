class MatchSimulator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, batting_team)
    @number_of_overs = number_of_overs
    @target = target
    @batting_team = batting_team
    @number_of_balls_left = number_of_overs * BALLS_IN_AN_OVER
  end

  def simulate
    commentator = Commentator.new(@number_of_overs, @target, played_balls, @batting_team)
    [commentator.result] + @batting_team.scores + commentator.commentary
  end

  private
  def played_balls
    @number_of_balls_left.times.inject([]) do |played_balls, ball_number|
      played_ball, @batting_team = @batting_team.play(ball_number + 1)
      played_balls << played_ball
    end
  end
end