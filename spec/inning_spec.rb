require 'spec_helper'
require 'inning'
require 'played_ball'
require 'played_over'

describe Inning do
  let(:overs) { [instance_double(PlayedOver, runs_scored: 8, wickets_lost: 1, balls_played: 6,
                                 comments: ['0.1 Kirat Boli scores 1 run',
                                            '0.2 NS Nodhi scores 4 runs', '0.3 NS Nodhi gets out',
                                            '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run',
                                            '0.6 R Rumrah scores 1 run',]),
                 instance_double(PlayedOver, runs_scored: 4, wickets_lost: 1, balls_played: 6,
                                 comments: ['1.1 Kirat Boli scores 1 run', '1.2 R Rumrah scores 1 run',
                                            '1.3 Kirat Boli gets out', '1.4 Irfan scores 1 run',
                                            '1.5 R Rumrah scores 1 run', '1.6 Irfan gets out']),
                 instance_double(UnPlayedOver, runs_scored: 0, wickets_lost: 0, balls_played: 0, comments: [])] }
  let(:number_of_overs) { 3 }
  let(:target) { 14 }
  let(:team) { instance_double(Team, name: 'Lengaburu', size: 4) }

  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      expect(overs[0]).to receive(:played?).and_return(true)
      expect(overs[1]).to receive(:played?).and_return(true)
      expect(overs[2]).to receive(:played?).and_return(false)

      actual_commentary = Inning.new(target, overs, team).commentary

      expected_commentary = ['3 overs left. 14 runs to win', '0.1 Kirat Boli scores 1 run', '0.2 NS Nodhi scores 4 runs',
                             '0.3 NS Nodhi gets out', '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run',
                             '0.6 R Rumrah scores 1 run', '2 overs left. 6 runs to win', '1.1 Kirat Boli scores 1 run',
                             '1.2 R Rumrah scores 1 run', '1.3 Kirat Boli gets out', '1.4 Irfan scores 1 run',
                             '1.5 R Rumrah scores 1 run', '1.6 Irfan gets out', '1 overs left. 2 runs to win']
      expect(actual_commentary).to eq expected_commentary
    end
  end

  describe '#result' do
    let(:overs) { [instance_double(PlayedOver, runs_scored: 10, balls_played: 6, wickets_lost: 1),
                   instance_double(PlayedOver, runs_scored: 4, balls_played: 6, wickets_lost: 1)] }
    context 'given team has won the match' do
      describe 'team scores exactly the target' do
        it 'returns win result' do
          actual_result = Inning.new(14, overs, team).result

          expect(actual_result).to eq 'Lengaburu won by 2 wickets and 0 balls remaining'
        end
      end

      describe 'team scores more than the target' do
        it 'returns win result' do
          actual_result = Inning.new(12, overs, team).result

          expect(actual_result).to eq 'Lengaburu won by 2 wickets and 0 balls remaining'
        end
      end
    end

    context 'given team has lost the match' do
      it 'returns loss result' do
        actual_result = Inning.new(16, overs, team).result

        expect(actual_result).to eq 'Lengaburu lost by 2 runs'
      end
    end
  end
end