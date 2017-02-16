class ScoreCard
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, outcomes)
    @total_overs = number_of_overs
    @current_over = -1
    @target = target
    @outcomes = outcomes
  end

  def commentary
    commentary = (@total_overs * BALLS_IN_AN_OVER).times.inject([]) do |commentary, ball_number|
      if first_or_last_ball_of_over?(ball_number)
        @current_over +=1
        commentary << over_commentary
      end
      current_outcome = @outcomes[ball_number]
      @target -= current_outcome.runs_scored
      commentary << "#{@current_over}.#{ball_number_within_over(ball_number)} #{current_outcome.commentary}"
    end
    @current_over += 1
    commentary << over_commentary
  end

  private
  def ball_number_within_over(ball_number)
    if first_or_last_ball_of_over?(ball_number + 1)
      6
    else
      (ball_number + 1) % BALLS_IN_AN_OVER
    end
  end

  def first_or_last_ball_of_over?(ball_number)
    (ball_number % BALLS_IN_AN_OVER) == 0
  end

  def over_commentary
    "#{@total_overs - @current_over} overs left. #{@target} runs to win"
  end
end