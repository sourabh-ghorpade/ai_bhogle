require 'spec_helper'
require 'played_over'
require 'played_ball'

describe PlayedOver do
  describe '#comments' do
    it 'aggregates comments of balls' do
      over = PlayedOver.new(1, [instance_double(PlayedBall, comment: 'Virat Kohli scores 1 run'),
                                instance_double(PlayedBall, comment: 'MS Dhoni gets out!'),
                                instance_double(PlayedBall, comment: 'Bumrah scores 1 run'),
                                instance_double(PlayedBall, comment: 'Virat Kohli scores 1 run'),
                                instance_double(PlayedBall, comment: 'Bumrah scores 1 run'),
                                instance_double(PlayedBall, comment: 'Virat Kohli scores 1 run')])

      expected_comments= ['1.1 Virat Kohli scores 1 run', '1.2 MS Dhoni gets out!', '1.3 Bumrah scores 1 run',
                          '1.4 Virat Kohli scores 1 run', '1.5 Bumrah scores 1 run', '1.6 Virat Kohli scores 1 run']

      expect(over.comments).to eq expected_comments
    end
  end

  describe '#runs_scored' do
    it 'returns sum of runs scored in the played balls' do
      over = PlayedOver.new(1, [instance_double(PlayedBall, runs_scored: 2),
                                instance_double(PlayedBall, runs_scored: 3)])

      expect(over.runs_scored).to eq 5
    end
  end

  describe '#wickets_lost' do
    it 'returns sum of wickets lost in the played balls' do
      over = PlayedOver.new(1, [instance_double(PlayedBall, out?: true),
                                instance_double(PlayedBall, out?: false),
                                instance_double(PlayedBall, out?: true)])

      expect(over.wickets_lost).to eq 2
    end
  end

  describe '#balls_played' do
    it 'returns number of played balls' do
      over = PlayedOver.new(1, [instance_double(PlayedBall), instance_double(PlayedBall), instance_double(PlayedBall)])

      expect(over.balls_played).to eq 3
    end
  end

  describe '#played' do
    it 'returns true' do
      expect(PlayedOver.new(1,2).played?).to eq true
    end
  end
end