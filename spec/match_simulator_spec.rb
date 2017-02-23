require 'spec_helper'
require 'played_over'

describe MatchSimulator do
  describe '#simulate' do
    it 'returns match result' do
      team = instance_double(Team)
      number_of_overs = 4
      target = 40
      over = instance_double(PlayedOver)
      1...number_of_overs.times do |over_number|
        expect(team).to receive(:play).with(over_number + 1).and_return([over, team])
      end
      played_overs = [over, over, over, over]
      commentator = instance_double(Commentator)
      expect(Commentator).to receive(:new)
                                 .with(number_of_overs, target, array_including(played_overs), team)
                                 .and_return(commentator)
      commentary = ['0.1 Kirat Boli scores 1 run']
      expect(commentator).to receive(:commentary).and_return(commentary)
      result = 'Lengaburu won by 1 wicket and 2 balls remaining'
      expect(commentator).to receive(:result).and_return(result)
      final_score_card = ['Kirat Boli - 12 (6 balls)']
      expect(team).to receive(:scores).and_return(final_score_card)

      actual_result = MatchSimulator.new(number_of_overs, target, team).simulate

      expect(actual_result).to eq [result] + final_score_card + commentary
    end
  end
end