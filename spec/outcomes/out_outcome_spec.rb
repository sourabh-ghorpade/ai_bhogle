require 'spec_helper'
require 'outcomes/out_outcome'
require 'team'
require 'batsman'

describe Outcomes::OutOutcome do
  describe '#resultant_team' do
    let(:striker) { instance_double(Batsman) }
    let(:non_striker) { instance_double(Batsman) }
    let(:out_batsmen) { [instance_double(Batsman)] }
    let(:next_batsman) { [instance_double(Batsman)] }
    let(:yet_to_play_batsmen) { [next_batsman] }

    it 'returns a new team with next batsman on strike' do
      resultant_team = instance_double(Team)
      expect(Team).to receive(:new)
                          .with(next_batsman, non_striker, yet_to_play_batsmen, out_batsmen << striker)
                          .and_return(resultant_team)

      actual_team = Outcomes::OutOutcome.new.resultant_team(striker, non_striker, yet_to_play_batsmen, out_batsmen, true)

      expect(actual_team).to eq resultant_team
    end
  end

  describe '#runs_scored' do
    it 'returns 0' do
      expect(Outcomes::OutOutcome.new.runs_scored).to eq 0
    end
  end
end