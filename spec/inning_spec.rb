require 'spec_helper'
require 'inning'
require 'played_ball'
require 'played_over'

describe Inning do
  let(:overs) { [instance_double(PlayedOver, runs_scored: 10, wickets_lost: 1, balls_played: 6,
                                 comments: ['2 overs left. 14 runs to win', '0.1 Kirat Boli scores 1 run',
                                            '0.2 NS Nodhi scores 4 runs', '0.3 NS Nodhi is out',
                                            '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run',
                                            '0.6 R Rumrah scores 1 run', '1 overs left. 6 runs to win']),
                 instance_double(PlayedOver, runs_scored: 5, wickets_lost: 1, balls_played: 6,
                                 comments: ['1.1 Kirat Boli scores 1 run', '1.2 R Rumrah scores 1 run',
                                            '1.3 Kirat Boli scores 1 run', '1.4 R Rumrah scores 1 run',
                                            '1.5 Kirat Boli scores 1 run', '1.6 R Rumrah scores 1 run',
                                            '0 overs left. 0 runs to win'])] }
  let(:number_of_overs) { 2 }
  let(:target) { 14 }
  let(:team) { instance_double(Team, name: 'Lengaburu', size: 4) }


  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      actual_commentary = Inning.new(number_of_overs, target, overs, team).commentary

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
        actual_result = Inning.new(3, target, overs, team).result

        expect(actual_result).to eq 'Lengaburu won by 2 wickets and 0 balls remaining'
      end
    end

    context 'given team has lost the match' do
      it 'returns loss result' do
        actual_result = Inning.new(3, 16, overs, team).result

        expect(actual_result).to eq 'Lengaburu lost by 1 runs'
      end
    end
  end
end