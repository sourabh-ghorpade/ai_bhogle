class PlayedBall
  BALLS_IN_AN_OVER = 6

  def initialize(number, outcome, batsman)
    @ball_number = number
    @outcome = outcome
    @batsman = batsman
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
    "#{over_number}.#{number_within_over} #{batsman_name} scores #{runs_scored} runs"
  end

  def runs_scored
    @outcome.runs_scored
  end

  def batsman_name
    @batsman.name
  end

  def out?
    @outcome.out?
  end

  def resultant_team(name, striker, non_striker, yet_to_play_batsmen, out_batsmen)
    @outcome.resultant_team(name, striker, non_striker, yet_to_play_batsmen, out_batsmen, last_ball_of_over?)
  end
end