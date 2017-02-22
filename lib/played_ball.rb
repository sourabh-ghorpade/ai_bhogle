class PlayedBall
  BALLS_IN_AN_OVER = 6

  def initialize(number, outcome)
    @ball_number = number
  end

  def runs_scored

  end

  def batsman_name

  end

  def number_within_over

  end

  def over_number
    last_ball_of_over? ? (@ball_number / BALLS_IN_AN_OVER) - 1 : @ball_number / BALLS_IN_AN_OVER
  end

  def last_ball_of_over?
    (@ball_number % BALLS_IN_AN_OVER) == 0
  end

  def comment

  end

  def out?

  end
end