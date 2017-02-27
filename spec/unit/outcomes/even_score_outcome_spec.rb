require 'spec_helper'
require 'outcomes/even_score_outcome'
require 'team'
require 'batsman'

describe Outcomes::EvenScoreOutcome do
  describe '#resultant_team' do
    let(:striker) { instance_double(Batsman) }
    let(:non_striker) { instance_double(Batsman) }
    let(:out_batsmen) { [instance_double(Batsman)] }
    let(:yet_to_play_batsmen) { [instance_double(Batsman)] }
    let(:team_name) { 'Lengaburu' }

    context 'when it is the last ball of the over' do
      it 'returns a new team with same strike positions' do
        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen).and_return(resultant_team)

        actual_team = Outcomes::EvenScoreOutcome.new(2).resultant_team(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen, true)

        expect(actual_team).to eq resultant_team
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns a new team with the rotated strike positions' do
        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(team_name, non_striker, striker, yet_to_play_batsmen, out_batsmen).and_return(resultant_team)

        actual_team = Outcomes::EvenScoreOutcome.new(2).resultant_team(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen, false)

        expect(actual_team).to eq resultant_team
      end
    end
  end

  describe '#runs_scored' do
    it 'returns runs scored' do
      expect(Outcomes::EvenScoreOutcome.new(10).runs_scored).to eq 10
    end
  end

  describe '#out?' do
    it 'returns false' do
      expect(Outcomes::EvenScoreOutcome.new(3).out?).to eq false
    end
  end
end
