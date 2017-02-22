require 'spec_helper'
require 'played_ball'
require 'outcomes/even_score_outcome'
require 'outcomes/out_outcome'

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

  describe '#number_within_over' do
    context 'when it is the last ball of the over' do
      it 'returns 6' do
        expect(PlayedBall.new(12, double('Outcome')).number_within_over).to eq 6
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns the number within the over for the ball number' do
        expect(PlayedBall.new(11, double('Outcome')).number_within_over).to eq 5
      end
    end
  end

  describe '#runs_scored' do
    it 'returns the runs scored' do
      outcome = double('Outcome', runs_scored: 3)
      expect(PlayedBall.new(11, outcome).runs_scored).to eq 3
    end
  end

  describe '#batsman_name' do
    it 'returns the batsman name' do
      outcome = double('Outcome', batsman_name: 'Some Name')
      expect(PlayedBall.new(11, outcome).batsman_name).to eq 'Some Name'
    end
  end

  describe '#out?' do
    context 'it is an out outcome' do
      it 'returns true' do
        outcome = instance_double(Outcomes::OutOutcome, out?: true)
        expect(PlayedBall.new(11, outcome).out?).to eq true
      end
    end

    context 'it is not an out outcome' do
      it 'returns false' do
        outcome = instance_double(Outcomes::EvenScoreOutcome, out?: false)
        expect(PlayedBall.new(11, outcome).out?).to eq false
      end
    end
  end

  describe '#comment' do
    it 'returns score comment for the ball' do
      outcome = double('Outcome', comment: 'Kirat Boli scores 1 run')
      actual_comment = PlayedBall.new(11, outcome).comment

      expect(actual_comment).to eq '1.5 Kirat Boli scores 1 run'
    end
  end
end
