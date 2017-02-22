class Batsman
  attr_reader :name
  def initialize(name, shot_probabilities, runs_scored = 0, balls_faced = 0)
    @name = name
    @shot_probabilities = shot_probabilities
    @runs_scored = runs_scored
    @balls_faced = balls_faced
  end

  def play(ball_number)
    outcome = External::WeightedProbabilityPicker.new(@shot_probabilities).pick
    ball = PlayedBall.new(ball_number, outcome, self)
    return ball, Batsman.new(@name, @shot_probabilities, @runs_scored + outcome.runs_scored, @balls_faced + 1)
  end

  def score
    "#{@name}- #{@runs_scored} (#{@balls_faced} balls)"
  end
end