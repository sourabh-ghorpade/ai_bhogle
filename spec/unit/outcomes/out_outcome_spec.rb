require 'spec_helper'

describe Outcomes::OutOutcome do
  describe '#resultant_team' do
    let(:striker) { instance_double(Batsman) }
    let(:non_striker) { instance_double(Batsman) }
    let(:out_batsmen) { [instance_double(Batsman)] }
    let(:next_batsman) { [instance_double(Batsman)] }
    let(:yet_to_play_batsmen) { [next_batsman] }
    let(:team_name) { 'Lengaburu' }
    context 'there are batsmen remaining' do
      it 'returns a new team with next batsman on strike' do
        resultant_team = instance_double(Team)
        expect(Team).to receive(:new)
                            .with(team_name, next_batsman, non_striker, yet_to_play_batsmen, out_batsmen << striker)
                            .and_return(resultant_team)

        actual_team = Outcomes::OutOutcome.new.resultant_team(team_name, striker, non_striker, yet_to_play_batsmen, out_batsmen, true)

        expect(actual_team).to eq resultant_team
      end
    end

    context 'there are no batsmen remaining' do
      it 'returns an AllOutTeam with remaining batsmen as empty' do
        resultant_team = instance_double(Team)
        expect(AllOutTeam).to receive(:new)
                                  .with(team_name, out_batsmen + [striker, non_striker])
                                  .and_return(resultant_team)

        actual_team = Outcomes::OutOutcome.new.resultant_team(team_name, striker, non_striker, [], out_batsmen, true)

        expect(actual_team).to eq resultant_team
      end
    end
  end

  describe '#runs_scored' do
    it 'returns 0' do
      expect(Outcomes::OutOutcome.new.runs_scored).to eq 0
    end
  end

  describe '#out?' do
    it 'returns true' do
      expect(Outcomes::OutOutcome.new.out?).to eq true
    end
  end
end