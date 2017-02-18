require 'spec_helper'
require 'commentator'
require 'played_ball'

describe Commentator do
  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      outcomes = [instance_double(PlayedBall, runs_scored: 1, over_number: 0, comment: '0.1 Kirat Boli scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 4, over_number: 0, comment: '0.2 NS Nodhi scores 4 runs', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 0, over_number: 0, comment: '0.3 NS Nodhi is out', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 0, comment: '0.4 R Rumrah scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 0, comment: '0.5 Kirat Boli scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 0, comment: '0.6 R Rumrah scores 1 run', last_ball_of_over?: true),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.1 Kirat Boli scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.2 R Rumrah scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.3 Kirat Boli scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.4 R Rumrah scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.5 Kirat Boli scores 1 run', last_ball_of_over?: false),
                  instance_double(PlayedBall, runs_scored: 1, over_number: 1, comment: '1.6 R Rumrah scores 1 run', last_ball_of_over?: true)]
      number_of_overs = 2
      target = 40
      actual_commentary = Commentator.new(number_of_overs, target, outcomes).commentary

      expected_commentary = ['2 overs left. 40 runs to win', '0.1 Kirat Boli scores 1 run', '0.2 NS Nodhi scores 4 runs',
                             '0.3 NS Nodhi is out', '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run',
                             '0.6 R Rumrah scores 1 run', '1 overs left. 32 runs to win', '1.1 Kirat Boli scores 1 run',
                             '1.2 R Rumrah scores 1 run', '1.3 Kirat Boli scores 1 run', '1.4 R Rumrah scores 1 run',
                             '1.5 Kirat Boli scores 1 run', '1.6 R Rumrah scores 1 run', '0 overs left. 26 runs to win']
      expect(actual_commentary).to eq expected_commentary
    end
  end
end