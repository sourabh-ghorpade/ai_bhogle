class ScoreCard
  def initialize(batsmen)
    @batsmen = batsmen
  end

  def to_a
    @batsmen.map(&:score_description)
  end
end