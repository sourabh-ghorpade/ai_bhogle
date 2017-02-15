require 'spec_helper'
require 'score_card'

describe ScoreCard do
  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      outcomes = [instance_double('Outcome', runs_scored: 1, commentary: 'Kirat Boli scores 1 run'),
                  instance_double('Outcome', runs_scored: 4, commentary: 'NS Nodhi scores 4 runs'),
                  instance_double('Outcome', runs_scored: 0, commentary: 'NS Nodhi is out'),
                  instance_double('Outcome', runs_scored: 1, commentary: 'R Rumrah scores 1 run'),
                  instance_double('Outcome', runs_scored: 1, commentary: 'Kirat Boli scores 1 run'),
                  instance_double('Outcome', runs_scored: 1, commentary: 'R Rumrah scores 1 run')]
      number_of_overs = 1
      target = 40
      actual_commentary = ScoreCard.new(number_of_overs, target, outcomes).commentary

      expected_commentary = ['1 overs left. 40 runs to win', '0.1 Kirat Boli scores 1 run', '0.2 NS Nodhi scores 4 runs', '0.3 NS Nodhi is out',
                             '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run', '0.6 R Rumrah scores 1 run', '0 overs left. 32 runs to win']
      expect(actual_commentary).to eq expected_commentary
    end
  end
end