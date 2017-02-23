require 'spec_helper'
require 'all_out_team'
require 'played_ball'
require 'batsman'
require 'un_played_over'
require 'played_over'

describe AllOutTeam do
  let(:out_batsmen) { [instance_double(Batsman, score: 'B1 - 12 (2 balls)'),
                       instance_double(Batsman, score: 'B2 - 2 (2 balls)')] }
  let(:team) { AllOutTeam.new('Lengaburu', out_batsmen) }

  describe '#play' do
    context 'when no balls have been played' do
      it 'returns UnPlayedOver' do
        expected_over = instance_double(UnPlayedOver)
        expect(UnPlayedOver).to receive(:new).and_return(expected_over)

        actual_over = team.play(2)

        expect(actual_over).to eq expected_over
      end
    end

    context 'when some balls have been played' do
      it 'returns PlayedOver' do
        played_balls = [instance_double(PlayedBall)]
        expected_over = instance_double(PlayedOver)
        expect(PlayedOver).to receive(:new).with(played_balls).and_return(expected_over)

        actual_over = team.play(2, played_balls)

        expect(actual_over).to eq expected_over
      end
    end
  end

  describe '#scores' do
    it 'returns scores of all batsmen' do
      expected_scores = ['B1 - 12 (2 balls)', 'B2 - 2 (2 balls)']

      actual_scores = team.scores

      expect(actual_scores).to eq expected_scores
    end
  end

  describe '#size' do
    it 'returns the size of the team' do
      actual_size = team.size

      expect(actual_size).to eq 2
    end
  end

  describe '#name' do
    it 'returns the name of the team' do
      expect(team.name).to eq 'Lengaburu'
    end
  end
end