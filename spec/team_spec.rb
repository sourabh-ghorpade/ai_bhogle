require 'spec_helper'
require 'team'
require 'batsman'
require 'outcomes/out_outcome'
require 'outcomes/even_score_outcome'
require 'score_card'

describe Team do
  let(:striker) { instance_double(Batsman) }
  let(:non_striker) { instance_double(Batsman) }
  let(:another_batsman) { instance_double(Batsman) }
  let(:out_batsmen) { [instance_double(Batsman)] }
  let(:yet_to_play_batsmen) { [another_batsman] }

  describe '#play' do
    it 'returns returns outcome of playing the ball and resultant team' do
      outcome = instance_double('Outcome')
      expect(striker).to receive(:play).and_return(outcome)
      expected_resultant_team = instance_double(Team)
      is_last_ball = true
      expect(outcome).to receive(:resultant_team)
                             .with(striker, non_striker, yet_to_play_batsmen, out_batsmen, is_last_ball)
                             .and_return(expected_resultant_team)

      actual_outcome, actual_team = Team.new(striker, non_striker, yet_to_play_batsmen, out_batsmen).play(is_last_ball)

      expect(actual_outcome).to eq outcome
      expect(actual_team).to eq expected_resultant_team
    end
  end

  describe '#score_card' do
    it 'returns score card of current batsmen' do
      expected_score_card = instance_double(ScoreCard)
      all_batsmen = [striker, non_striker] + yet_to_play_batsmen + out_batsmen
      expect(ScoreCard).to receive(:new).with(all_batsmen).and_return(expected_score_card)

      actual_score_card = Team.new(striker, non_striker, yet_to_play_batsmen, out_batsmen).score_card

      expect(actual_score_card).to eq expected_score_card
    end
  end
end