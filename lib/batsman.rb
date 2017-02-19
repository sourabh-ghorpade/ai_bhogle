class Batsman
  def initialize(shot_probabilities)
    @shot_probability = {
        Outcomes::EvenScoreOutcome.new(0) => shot_probabilities[0], Outcomes::OddScoreOutcome.new(1) => shot_probabilities[1],
        Outcomes::EvenScoreOutcome.new(2) => shot_probabilities[2], Outcomes::OddScoreOutcome.new(3) => shot_probabilities[3],
        Outcomes::EvenScoreOutcome.new(4) => shot_probabilities[4], Outcomes::OddScoreOutcome.new(5) => shot_probabilities[5],
        Outcomes::EvenScoreOutcome.new(6) => shot_probabilities[6], Outcomes::OutOutcome.new => shot_probabilities[7]
    }
  end

  def play
    External::WeightedProbabilityPicker.new(@shot_probability).pick
  end

  def score_description

  end
end