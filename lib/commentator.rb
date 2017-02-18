class Commentator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, played_balls)
    @total_overs = number_of_overs
    @current_over = -1
    @target = target
    @played_balls = played_balls
    @individual_scores = {}
  end

  def commentary
    @played_balls.inject([over_commentary(0)]) do |comments, ball|
      @target -= ball.runs_scored
      comments << ball.comment
      if ball.last_ball_of_over?
        comments << over_commentary(ball.over_number + 1)
      end
      comments
    end
  end

  private
  def over_commentary(current_over)
    "#{@total_overs - current_over} overs left. #{@target} runs to win"
  end
end