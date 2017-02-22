class PlayedBall
  BALLS_IN_AN_OVER = 6

  def initialize(number, outcome)
    @ball_number = number
    @outcome = outcome
  end

  def number_within_over
    last_ball_of_over? ? 6 : @ball_number % BALLS_IN_AN_OVER
  end

  def over_number
    last_ball_of_over? ? (@ball_number / BALLS_IN_AN_OVER) - 1 : @ball_number / BALLS_IN_AN_OVER
  end

  def last_ball_of_over?
    (@ball_number % BALLS_IN_AN_OVER) == 0
  end

  def comment
    "#{over_number}.#{number_within_over} #{@outcome.comment}"
  end

  def runs_scored
    @outcome.runs_scored
  end

  def batsman_name
    @outcome.batsman_name
  end

  def out?
    @outcome.out?
  end
end