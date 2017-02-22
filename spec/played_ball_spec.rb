require 'spec_helper'
require 'played_ball'

describe PlayedBall do
  describe '#last_ball_of_over?' do
    context 'when it is the last ball of the over' do
      it 'returns true' do
        expect(PlayedBall.new(6, double('Outcome'))).to be_last_ball_of_over
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns true' do
        expect(PlayedBall.new(1, double('Outcome'))).not_to be_last_ball_of_over
      end
    end
  end

  describe '#over_number' do
    context 'when it is the last ball of the over' do
      it 'returns the over same over number as other balls in that over' do
        expect(PlayedBall.new(12, double('Outcome')).over_number).to eq 1
      end
    end
    context 'when it is not the last ball of the over' do
      it 'returns the over number for a particular ball number' do
        expect(PlayedBall.new(11, double('Outcome')).over_number).to eq 1
      end
    end
  end
end
