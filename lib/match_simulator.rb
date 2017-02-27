class MatchSimulator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, batting_team)
    @number_of_overs = number_of_overs
    @target = target
    @batting_team = batting_team
    @number_of_overs = number_of_overs
  end

  def simulate
    inning = Inning.new(@target, overs, @batting_team)
    [inning.result] + @batting_team.scores + inning.commentary
  end

  private
  def overs
    balls_played = played_balls
    overs_to_build = (balls_played.count / BALLS_IN_AN_OVER) != 0 ? (balls_played.count / BALLS_IN_AN_OVER) : 1
    overs_to_build.times.inject([]) do |overs, over_number|
      played_over_new = PlayedOver.new(over_number + 1, balls_played.shift(BALLS_IN_AN_OVER))
      overs << played_over_new
    end
  end

  def played_balls
    runs_to_win = @target
    (@number_of_overs * BALLS_IN_AN_OVER).times.inject([]) do |played_balls, ball_number|
      played_ball, @batting_team = @batting_team.play(ball_number + 1)
      runs_to_win -= played_ball.runs_scored
      played_balls << played_ball
      if runs_to_win <= 0 || @batting_team.all_out?
        return played_balls
      else
        played_balls
      end
    end
  end
end