require 'spec_helper'
require 'score_card'

describe ScoreCard do
  describe '#generate_commentry' do
    it 'returns commentary of the outcomes' do
      outcomes = [instance_double('Outcome', to_s: 'Kirat Boli scores 1 run'), instance_double('Outcome', to_s: 'NS Nodhi scores 4 runs'),
                  instance_double('Outcome', to_s: 'NS Nodhi is out'), instance_double('Outcome', to_s: 'R Rumrah scores 1 run'),
                  instance_double('Outcome', to_s: 'Kirat Boli scores 1 run'), instance_double('Outcome', to_s: 'R Rumrah scores 1 run')]
      actual_commentary = ScoreCard.new(outcomes).commentary

      expected_commentary = ['0.1 Kirat Boli scores 1 run', '0.2 NS Nodhi scores 4 runs', '0.3 NS Nodhi is out',
                             '0.4 R Rumrah scores 1 run', '0.5 Kirat Boli scores 1 run', '0.6 R Rumrah scores 1 run']
      expect(actual_commentary).to eq expected_commentary
    end
  end
end