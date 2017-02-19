require 'spec_helper'
require 'score_card'
require 'batsman'

describe ScoreCard do
  describe '#to_a' do
    it 'returns batsmen stats' do
      batsmen = [instance_double(Batsman, score_description: 'Kirat Boli - 12 (6 balls)'),
                 instance_double(Batsman, score_description: 'NS Nodhi - 25 (11 balls)')]
      expected_stats = ['Kirat Boli - 12 (6 balls)', 'NS Nodhi - 25 (11 balls)']

      actual_stats = ScoreCard.new(batsmen).to_a

      expect(actual_stats).to eq expected_stats
    end
  end
end
