class Batsman
  def initialize(name, runs_scored, balls_faced, shot_probabilities)
    @name = name
    @runs_scored = runs_scored
    @balls_faced = balls_faced
    @shot_probabilities = shot_probabilities
  end

  def play
    outcome = External::WeightedProbabilityPicker.new(@shot_probabilities).pick
    return outcome, Batsman.new(@name, @runs_scored + outcome.runs_scored, @balls_faced + 1, @shot_probabilities)
  end

  def score
    "#{@name}- #{@runs_scored} (#{@balls_faced} balls)"
  end
end