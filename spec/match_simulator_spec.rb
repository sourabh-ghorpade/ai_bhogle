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
      played_balls = (1...24).each.inject([]) { |balls| balls << ball }
      commentator = instance_double(Commentator)

      target = 40
      number_of_overs = 4
      expect(Commentator).to receive(:new).with(number_of_overs, target, array_including(played_balls), team).and_return(commentator)
      commentary = ['0.1 Kirat Boli scores 1 run']
      expect(commentator).to receive(:commentary).and_return(commentary)
      result = 'Lengaburu won by 1 wicket and 2 balls remaining'
      expect(commentator).to receive(:result).and_return(result)
      final_score_card = ['Kirat Boli - 12 (6 balls)']
      expect(team).to receive(:scores).and_return(final_score_card)

      actual_result = MatchSimulator.new(number_of_overs, target, team).simulate

      expect(actual_result).to eq [result] + final_score_card + commentary
    end
  end
end