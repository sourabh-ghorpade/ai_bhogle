class ScoreCard
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, outcomes)
    @total_overs = number_of_overs
    @overs_left = number_of_overs
    @target = target
    @outcomes = outcomes
  end

  def commentary
    commentary = (@total_overs * BALLS_IN_AN_OVER).times.inject([over_commentary]) do |commentary, ball_number|
      current_outcome = @outcomes[ball_number]
      @target -= current_outcome.runs_scored
      commentary = commentary << "#{@total_overs - @overs_left}.#{ball_number + 1} #{current_outcome.commentary}"
      if @overs_left != 1 && (ball_number % 6) == 0
        @overs_left -= 1
      end
      commentary
    end
    @overs_left -= 1
    commentary << over_commentary
  end

  private
  def over_commentary
    "#{@overs_left} overs left. #{@target} runs to win"
  end
end