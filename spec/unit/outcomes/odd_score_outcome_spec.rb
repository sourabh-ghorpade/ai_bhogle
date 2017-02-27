require 'spec_helper'
require 'outcomes/odd_score_outcome'
require 'team'
require 'batsman'

describe Outcomes::OddScoreOutcome do
  describe '#resultant_team' do
    let(:striker) { instance_double(Batsman) }
    let(:non_striker) { instance_double(Batsman) }
    let(:out_batsmen) { [instance_double(Batsman)] }
    let(:yet_to_play_batsmen) { [instance_double(Batsman)] }
    let(:team_name) { 'lengaburu' }

    context 'when it is the last ball of the over' do
      it 'returns a new team with rotated strike positions' do
        striker = instance_double(Batsman)
        non_striker = instance_double(Batsman)

        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(team_name, non_striker, striker, yet_to_play_batsmen, out_batsmen,).and_return(resultant_team)
        actual_team = Outcomes::OddScoreOutcome.new(2).resultant_team(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen, true)

        expect(actual_team).to eq resultant_team
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns a new team with same strike positions' do
        striker = instance_double(Batsman)
        non_striker = instance_double(Batsman)

        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen,).and_return(resultant_team)
        actual_team = Outcomes::OddScoreOutcome.new(2).resultant_team(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen, false)

        expect(actual_team).to eq resultant_team
      end
    end
  end

  describe '#runs_scored' do
    it 'returns runs scored' do
      expect(Outcomes::OddScoreOutcome.new(10).runs_scored).to eq 10
    end
  end

  describe '#out?' do
    it 'returns false' do
      expect(Outcomes::OddScoreOutcome.new(3).out?).to eq false
    end
  end
end