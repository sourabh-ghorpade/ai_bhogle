require 'spec_helper'
require 'match_simulator'
require 'team'
require 'score_card'

describe MatchSimulator do
  describe '#simulate' do
    it 'returns match result' do
      team = instance_double(Team)
      expected_result = instance_double(ScoreCard)
      outcome = double('Outcome')
      expect(team).to receive(:play).with(false).exactly(20).times.and_return(outcome)
      expect(team).to receive(:play).with(true).exactly(4).times.and_return(outcome)
      expect(ScoreCard).to receive(:new).and_return(expected_result)
      expect(expected_result).to receive(:add_outcome).exactly(24).times.with(outcome).and_return(expected_result)

      actual_result = MatchSimulator.new(4, team).simulate

      expect(actual_result).to eq expected_result
    end
  end
end