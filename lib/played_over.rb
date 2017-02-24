class PlayedOver
  def initialize(over_number, balls_played)
    @over_number = over_number
    @balls_played = balls_played
  end

  def comments
    @balls_played.map.with_index(1) { |played_ball, ball_number| "#{@over_number}.#{ball_number} #{played_ball.comment}" }
  end

  def runs_scored
    @balls_played.inject(0) { |total_runs_scored, ball| total_runs_scored + ball.runs_scored }
  end

  def wickets_lost
    @balls_played.select(&:out?).count
  end

  def balls_played
    @balls_played.count
  end

  def played?

  end
end