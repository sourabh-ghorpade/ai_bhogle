class Batsman
  def initialize(name, shot_probability)
    @name = name
    @shot_probability = shot_probability
  end

  def play
    result
  end

  private
  def result
    OutOutcome.new || ScoreOutCome
  end
end