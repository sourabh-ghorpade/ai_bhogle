require 'spec_helper'

describe AllOutTeam do
  let(:out_batsmen) { [instance_double(Batsman, score: 'B1 - 12 (2 balls)'),
                       instance_double(Batsman, score: 'B2 - 2 (2 balls)')] }
  let(:team) { AllOutTeam.new('Lengaburu', out_batsmen) }

  describe '#all_out?' do
    it 'returns true' do
      expect(team).to be_all_out
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