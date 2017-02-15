require 'spec_helper'
require 'outcomes/out_outcome'
require 'team'
require 'batsman'

describe Outcomes::OutOutcome do
  describe '#resultant_team' do
    it 'returns a new team with next batsman on strike' do
      striker = instance_double(Batsman)
      non_striker = instance_double(Batsman)
      another_batsman = instance_double(Batsman)
      remaining_batsmen = [another_batsman]

      resultant_team = instance_double(Team)
      expect(Team).to receive(:new).with([], another_batsman, non_striker).and_return(resultant_team)
      actual_team = Outcomes::OutOutcome.new.resultant_team(remaining_batsmen, striker, non_striker, true)

      expect(actual_team).to eq resultant_team
    end
  end
end