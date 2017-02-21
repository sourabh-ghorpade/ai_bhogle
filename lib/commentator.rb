class Commentator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, played_balls, team)
    @total_overs = number_of_overs
    @current_over = -1
    @target = target
    @played_balls = played_balls
    @individual_scores = {}
    @team = team
  end

  def commentary
    runs_required_to_win = @target
    @played_balls.inject([over_commentary(0, runs_required_to_win)]) do |comments, ball|
      runs_required_to_win -= ball.runs_scored
      comments << ball.comment
      if ball.last_ball_of_over?
        comments << over_commentary(ball.over_number + 1, runs_required_to_win)
      end
      comments
    end
  end

  def result
    balls_remaining = @total_overs * BALLS_IN_AN_OVER - @played_balls.count
    wickets_lost = @played_balls.select(&:out?).count
    "#{@team.name} won by #{@team.size - wickets_lost} wicket and #{balls_remaining} balls remaining"
  end

  private
  def over_commentary(current_over, runs_required_to_win)
    "#{@total_overs - current_over} overs left. #{runs_required_to_win} runs to win"
  end
end