require 'spec_helper'
require 'match_simulator'
require 'team'
require 'score_card'

describe MatchSimulator do
  describe '#simulate' do
    it 'returns match result' do
      team = instance_double(Team)
      outcome = double('Outcome')
      expect(team).to receive(:play).with(false).exactly(20).times.and_return([outcome, team])
      expect(team).to receive(:play).with(true).exactly(4).times.and_return([outcome, team])
      expected_outcomes = (1...24).each.inject([]) { |outcomes| outcomes << outcome}
      expected_scorecard = instance_double(ScoreCard)
      expect(ScoreCard).to receive(:new).with(array_including(expected_outcomes)).and_return(expected_scorecard)

      actual_result = MatchSimulator.new(4, team).simulate

      expect(actual_result).to eq expected_scorecard
    end
  end
end