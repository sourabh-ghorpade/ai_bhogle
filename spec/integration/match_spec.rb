require 'spec_helper'
require 'outcomes/even_score_outcome'
require 'outcomes/odd_score_outcome'
require 'outcomes/out_outcome'
require 'external/weighted_probability_picker'
require 'batsman'
require 'inning'
require 'match_simulator'
require 'played_ball'
require 'team'

describe 'Match Simulation' do
  xit 'runs the match simulation and returns the result' do
    virat_kohli_shot_probabilities =
        {
            Outcomes::EvenScoreOutcome.new(0) => 5, Outcomes::OddScoreOutcome.new(1) => 30,
            Outcomes::EvenScoreOutcome.new(2) => 25, Outcomes::OddScoreOutcome.new(3) => 10,
            Outcomes::EvenScoreOutcome.new(4) => 15, Outcomes::OddScoreOutcome.new(5) => 1,
            Outcomes::EvenScoreOutcome.new(6) => 9, Outcomes::OutOutcome.new => 5
        }
    dhoni_shot_probabilities =
        {
            Outcomes::EvenScoreOutcome.new(0) => 15, Outcomes::OddScoreOutcome.new(1) => 30,
            Outcomes::EvenScoreOutcome.new(2) => 15, Outcomes::OddScoreOutcome.new(3) => 10,
            Outcomes::EvenScoreOutcome.new(4) => 15, Outcomes::OddScoreOutcome.new(5) => 1,
            Outcomes::EvenScoreOutcome.new(6) => 9, Outcomes::OutOutcome.new => 5
        }
    irfan_shot_probabilities =
        {
            Outcomes::EvenScoreOutcome.new(0) => 20, Outcomes::OddScoreOutcome.new(1) => 30,
            Outcomes::EvenScoreOutcome.new(2) => 25, Outcomes::OddScoreOutcome.new(3) => 10,
            Outcomes::EvenScoreOutcome.new(4) => 0, Outcomes::OddScoreOutcome.new(5) => 1,
            Outcomes::EvenScoreOutcome.new(6) => 9, Outcomes::OutOutcome.new => 5
        }
    bumrah_probabilities =
        {
            Outcomes::EvenScoreOutcome.new(0) => 40, Outcomes::OddScoreOutcome.new(1) => 20,
            Outcomes::EvenScoreOutcome.new(2) => 0, Outcomes::OddScoreOutcome.new(3) => 0,
            Outcomes::EvenScoreOutcome.new(4) => 0, Outcomes::OddScoreOutcome.new(5) => 0,
            Outcomes::EvenScoreOutcome.new(6) => 0, Outcomes::OutOutcome.new => 40
        }

    virat_shot_picker = instance_double(External::WeightedProbabilityPicker)
    allow(External::WeightedProbabilityPicker).to receive(:new).with(virat_kohli_shot_probabilities).and_return(virat_shot_picker)
    allow(virat_shot_picker).to receive(:pick).and_return(Outcomes::EvenScoreOutcome.new(1))
    dhoni_shot_picker = instance_double(External::WeightedProbabilityPicker)
    allow(External::WeightedProbabilityPicker).to receive(:new).with(dhoni_shot_probabilities).and_return(dhoni_shot_picker)
    allow(dhoni_shot_picker).to receive(:pick).and_return(Outcomes::EvenScoreOutcome.new(1))

    team_name = 'Lengaburu'
    striker = Batsman.new('Virat Kohli', virat_kohli_shot_probabilities)
    non_striker = Batsman.new('MS Dhoni', dhoni_shot_probabilities)
    yet_to_play_batsmen = [Batsman.new('Irfan Khan', irfan_shot_probabilities), Batsman.new('Bumrah', bumrah_probabilities)]
    batting_team = Team.new(team_name, striker, non_striker, yet_to_play_batsmen, [])
    expected_result = ['Lengaburu won by 4 wickets and 0 balls remaining', 'Virat Kohli- 6 (6 balls)', 'MS Dhoni- 6 (6 balls)', 'Irfan Khan- 0 (0 balls)', 'Bumrah- 0 (0 balls)', '2 overs left. 12 runs to win', '0.1 Virat Kohli scores 1 runs', '0.2 Virat Kohli scores 1 runs', '0.3 Virat Kohli scores 1 runs', '0.4 Virat Kohli scores 1 runs', '0.5 Virat Kohli scores 1 runs', '0.6 Virat Kohli scores 1 runs', '1 overs left. 6 runs to win', '1.1 MS Dhoni scores 1 runs', '1.2 MS Dhoni scores 1 runs', '1.3 MS Dhoni scores 1 runs', '1.4 MS Dhoni scores 1 runs', '1.5 MS Dhoni scores 1 runs', '1.6 MS Dhoni scores 1 runs', '0 overs left. 0 runs to win']

    actual_result = MatchSimulator.new(2, 12, batting_team).simulate

    expect(actual_result).to eq expected_result
  end
end