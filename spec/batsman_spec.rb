require 'spec_helper'
require 'batsman'
require 'outcomes/even_score_outcome'
require 'outcomes/odd_score_outcome'
require 'outcomes/out_outcome'
require 'external/weighted_probability_picker'


describe Batsman do
  describe '#play' do
    it 'returns outcome of playing a ball' do
      shot_probabilities = {0 => 5, 1 => 30, 2 => 25, 3 => 10, 4 => 15, 5 => 1, 6 => 9, 7 => 5}
      dot_ball_outcome = instance_double(Outcomes::OddScoreOutcome)
      expect(Outcomes::EvenScoreOutcome).to receive(:new).with(0).and_return(dot_ball_outcome)
      one_run_outcome = instance_double(Outcomes::OddScoreOutcome)
      expect(Outcomes::OddScoreOutcome).to receive(:new).with(1).and_return(one_run_outcome)
      two_runs_outcome = instance_double(Outcomes::EvenScoreOutcome)
      expect(Outcomes::EvenScoreOutcome).to receive(:new).with(2).and_return(two_runs_outcome)
      three_runs_outcome = instance_double(Outcomes::OddScoreOutcome)
      expect(Outcomes::OddScoreOutcome).to receive(:new).with(3).and_return(three_runs_outcome)
      four_runs_outcome = instance_double(Outcomes::EvenScoreOutcome)
      expect(Outcomes::EvenScoreOutcome).to receive(:new).with(4).and_return(four_runs_outcome)
      five_runs_outcome = instance_double(Outcomes::OddScoreOutcome)
      expect(Outcomes::OddScoreOutcome).to receive(:new).with(5).and_return(five_runs_outcome)
      six_runs_outcome = instance_double(Outcomes::EvenScoreOutcome)
      expect(Outcomes::EvenScoreOutcome).to receive(:new).with(6).and_return(six_runs_outcome)
      out_outcome = instance_double(Outcomes::OutOutcome)
      expect(Outcomes::OutOutcome).to receive(:new).and_return(out_outcome)
      shot_picker = instance_double(External::WeightedProbabilityPicker)
      expect(External::WeightedProbabilityPicker).to receive(:new)
                                                         .with({dot_ball_outcome => 5, one_run_outcome => 30, two_runs_outcome => 25,
                                                                three_runs_outcome => 10, four_runs_outcome => 15, five_runs_outcome => 1,
                                                                six_runs_outcome => 9, out_outcome => 5})
                                                         .and_return(shot_picker)
      expect(shot_picker).to receive(:pick).and_return(three_runs_outcome)

      actual_outcome = Batsman.new('Virat Kohli', 0, 0, shot_probabilities).play

      expect(actual_outcome).to eq three_runs_outcome
    end
  end

  describe '#score_description' do
    it 'returns score description' do
      runs_scored = 10
      balls_faced = 4
      batsman = Batsman.new('Virat Kohli', runs_scored, balls_faced, {})

      expect(batsman.score_description).to eq 'Virat Kohli- 10 (4 balls)'
    end
  end
end