require 'spec_helper'
require 'un_played_over'

describe UnPlayedOver do
  let(:un_played_over) { UnPlayedOver.new }
  describe '#comments' do
    it 'returns blank array' do
      expect(un_played_over.comments).to eq []
    end
  end

  describe '#runs_scored' do
    it 'returns 0' do
      expect(un_played_over.runs_scored).to eq 0
    end
  end

  describe '#wickets_lost' do
    it 'returns sum of wickets lost in the played balls' do
      expect(un_played_over.wickets_lost).to eq 0
    end
  end

  describe '#balls_played' do
    it 'returns number of played balls' do
      expect(un_played_over.balls_played).to eq 0
    end
  end

  describe '#played' do
    it 'returns false' do
      expect(UnPlayedOver.new.played?).to eq false
    end
  end
end