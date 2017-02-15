require 'spec_helper'
require 'outcomes/even_score_outcome'
require 'team'
require 'batsman'

describe Outcomes::EvenScoreOutcome do
  describe '#resultant_team' do
    context 'when it is the last ball of the over' do
      it 'returns a new team with rotated strike positions' do
        striker = instance_double(Batsman)
        non_striker = instance_double(Batsman)
        batsmen = [striker, non_striker]

        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(batsmen, non_striker, striker).and_return(resultant_team)
        actual_team = Outcomes::EvenScoreOutcome.new(2).resultant_team(batsmen, striker, non_striker, true)

        expect(actual_team).to eq resultant_team
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns a new team with the same strike positions' do
        striker = instance_double(Batsman)
        non_striker = instance_double(Batsman)
        batsmen = [striker, non_striker]

        resultant_team = instance_double(Team)
        expect(Team).to receive(:new).with(batsmen, striker, non_striker).and_return(resultant_team)
        actual_team = Outcomes::EvenScoreOutcome.new(2).resultant_team(batsmen, striker, non_striker, false)

        expect(actual_team).to eq resultant_team
      end

    end
  end
end