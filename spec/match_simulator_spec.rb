require 'spec_helper'
require 'match_simulator'
require 'team'
require 'commentator'
require 'played_ball'

describe MatchSimulator do
  describe '#simulate' do
    it 'returns match result' do
      team = instance_double(Team)
      outcome = double('Outcome')
      expect(team).to receive(:play).with(false).exactly(20).times.and_return([outcome, team])
      expect(team).to receive(:play).with(true).exactly(4).times.and_return([outcome, team])
      ball = instance_double(PlayedBall)
      1...24.times do |ball_number|
        expect(PlayedBall).to receive(:new).with(ball_number, outcome).and_return(ball)
      end
      expected_balls = (1...24).each.inject([]) { |balls| balls << ball }
      expected_scorecard = instance_double(Commentator)

      target = 40
      number_of_overs = 4
      expect(Commentator).to receive(:new).with(number_of_overs, target, array_including(expected_balls)).and_return(expected_scorecard)

      actual_result = MatchSimulator.new(number_of_overs, target, team).simulate

      expect(actual_result).to eq expected_scorecard
    end
  end
end