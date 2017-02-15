class ScoreCard
  def initialize(outcomes)
    @outcomes = outcomes
  end

  def commentary
    @outcomes.each_with_index.map do |outcome, ball_number|
      "0.#{ball_number + 1} #{outcome.to_s}"
    end
  end
end