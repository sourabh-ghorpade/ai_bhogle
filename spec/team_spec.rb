require 'spec_helper'
require 'team'
require 'batsman'

describe Team do
  describe '#play' do
    it 'returns returns outcome of playing the ball and updates the onstrike batsman' do
      striker = instance_double(Batsman)
      non_striker = instance_double(Batsman)
      batsmen = [striker, non_striker]
      expected_outcome = instance_double('Outcome')
      expect(striker).to receive(:play).and_return(expected_outcome)
      expect(expected_outcome).to receive(:next_striker).with(striker, non_striker, batsmen, true).and_return(non_striker)

      team = Team.new(batsmen)
      actual_outcome = team.play(true)

      expect(actual_outcome).to eq expected_outcome
    end
  end
end