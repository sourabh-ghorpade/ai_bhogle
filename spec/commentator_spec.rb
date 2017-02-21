require 'spec_helper'
require 'commentator'
require 'played_ball'

describe Commentator do
  let(:outcomes) { [instance_double(PlayedBall, runs_scored: 1, over_number: 0, out?: false, comment: '0.1 Kirat Boli scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 4, over_number: 0, out?: false, comment: '0.2 NS Nodhi scores 4 runs', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 0, over_number: 0, out?: true, comment: '0.3 NS Nodhi is out', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 0, out?: false, comment: '0.4 R Rumrah scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 0, out?: false, comment: '0.5 Kirat Boli scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 0, out?: false, comment: '0.6 R Rumrah scores 1 run', last_ball_of_over?: true),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.1 Kirat Boli scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.2 R Rumrah scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.3 Kirat Boli scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.4 R Rumrah scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.5 Kirat Boli scores 1 run', last_ball_of_over?: false),
                    instance_double(PlayedBall, runs_scored: 1, over_number: 1, out?: false, comment: '1.6 R Rumrah scores 1 run', last_ball_of_over?: true)] }
  let(:number_of_overs) { 2 }
  let(:target) { 14 }
  let(:team) { instance_double(Team, name: 'Lengaburu', size: 4) }


  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      actual_commentary = Commentator.new(number_of_overs, target, outcomes, team).commentary

      expected_commentary = ['2 overs left. 14 runs to win', '0.1 Kirat Boli scores 1 run', '0.2 NS Nodhi scores 4 runs',
                             '0.3 NS Nodhi is out', '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run',
                             '0.6 R Rumrah scores 1 run', '1 overs left. 6 runs to win', '1.1 Kirat Boli scores 1 run',
                             '1.2 R Rumrah scores 1 run', '1.3 Kirat Boli scores 1 run', '1.4 R Rumrah scores 1 run',
                             '1.5 Kirat Boli scores 1 run', '1.6 R Rumrah scores 1 run', '0 overs left. 0 runs to win']
      expect(actual_commentary).to eq expected_commentary
    end
  end

  describe '#result' do
    context 'given team has won the match' do
      it 'returns win result' do
        actual_result = Commentator.new(3, target, outcomes, team).result

        expect(actual_result).to eq 'Lengaburu won by 3 wickets and 6 balls remaining'
      end
    end

    context 'given team has lost the match' do
      it 'returns loss result' do
        actual_result = Commentator.new(3, 16, outcomes, team).result

        expect(actual_result).to eq 'Lengaburu lost by 2 runs'
      end
    end
  end
end