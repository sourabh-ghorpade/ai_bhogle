require 'spec_helper'
require 'batsman'
require 'outcomes/even_score_outcome'
require 'outcomes/odd_score_outcome'
require 'outcomes/out_outcome'
require 'external/weighted_probability_picker'


describe Batsman do
  describe '#play' do
    it 'returns outcome of playing a ball' do
      three_runs_outcome = Outcomes::OddScoreOutcome.new(3)
      shot_probabilities =
          {
              Outcomes::EvenScoreOutcome.new(0) => 5, Outcomes::OddScoreOutcome.new(1) => 30,
              Outcomes::EvenScoreOutcome.new(2) => 25, three_runs_outcome => 10,
              Outcomes::EvenScoreOutcome.new(4) => 15, Outcomes::OddScoreOutcome.new(5) => 1,
              Outcomes::EvenScoreOutcome.new(6) => 9, Outcomes::OutOutcome.new => 5
          }
      shot_picker = instance_double(External::WeightedProbabilityPicker)
      expect(External::WeightedProbabilityPicker).to receive(:new).with(shot_probabilities).and_return(shot_picker)
      expect(shot_picker).to receive(:pick).and_return(three_runs_outcome)
      name = 'Virat Kohli'
      batsman = Batsman.new(name, 0, 0, shot_probabilities)
      expected_batsman = instance_double(Batsman)
      expect(Batsman).to receive(:new).with(name, 3, 1, shot_probabilities).and_return(expected_batsman)

      actual_outcome, actual_updated_batsman = batsman.play


      expect(actual_outcome).to eq three_runs_outcome
      expect(actual_updated_batsman).to eq expected_batsman
    end
  end

  describe '#score' do
    it 'returns score description' do
      runs_scored = 10
      balls_faced = 4
      batsman = Batsman.new('Virat Kohli', runs_scored, balls_faced, {})

      expect(batsman.score).to eq 'Virat Kohli- 10 (4 balls)'
    end
  end
end