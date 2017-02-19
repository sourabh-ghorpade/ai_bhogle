require 'spec_helper'
require 'team'
require 'batsman'
require 'outcomes/out_outcome'
require 'outcomes/even_score_outcome'

describe Team do
  describe '#play' do
    it 'returns returns outcome of playing the ball and resultant team' do
      striker = instance_double(Batsman)
      non_striker = instance_double(Batsman)
      another_batsman = instance_double(Batsman)
      all_batsmen = [striker, non_striker, another_batsman]
      outcome = instance_double('Outcome')
      expect(striker).to receive(:play).and_return(outcome)
      expected_resultant_team = instance_double(Team)
      is_last_ball = true
      remaining_batsmen = [another_batsman]
      expect(outcome).to receive(:resultant_team)
                             .with(all_batsmen, remaining_batsmen, striker, non_striker, is_last_ball)
                             .and_return(expected_resultant_team)

      actual_outcome, actual_team = Team.new(all_batsmen, remaining_batsmen, striker, non_striker).play(is_last_ball)

      expect(actual_outcome).to eq outcome
      expect(actual_team).to eq expected_resultant_team
    end
  end
end