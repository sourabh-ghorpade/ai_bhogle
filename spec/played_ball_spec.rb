require 'spec_helper'
require 'played_ball'
require 'batsman'
require 'outcomes/even_score_outcome'
require 'outcomes/out_outcome'

describe PlayedBall do
  let(:batsman) { instance_double(Batsman, name: 'Kirat Boli') }
  let(:outcome) { instance_double('Outcome') }
  describe '#last_ball_of_over?' do
    context 'when it is the last ball of the over' do
      it 'returns true' do
        expect(PlayedBall.new(6, outcome, batsman)).to be_last_ball_of_over
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns true' do
        expect(PlayedBall.new(1, outcome, batsman)).not_to be_last_ball_of_over
      end
    end
  end

  describe '#over_number' do
    context 'when it is the last ball of the over' do
      it 'returns the over same over number as other balls in that over' do
        expect(PlayedBall.new(12, outcome, batsman).over_number).to eq 1
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns the over number for a particular ball number' do
        expect(PlayedBall.new(11, outcome, batsman).over_number).to eq 1
      end
    end
  end

  describe '#number_within_over' do
    context 'when it is the last ball of the over' do
      it 'returns 6' do
        expect(PlayedBall.new(12, outcome, batsman).number_within_over).to eq 6
      end
    end

    context 'when it is not the last ball of the over' do
      it 'returns the number within the over for the ball number' do
        expect(PlayedBall.new(11, outcome, batsman).number_within_over).to eq 5
      end
    end
  end

  describe '#runs_scored' do
    it 'returns the runs scored' do
      outcome = double('Outcome', runs_scored: 3)
      expect(PlayedBall.new(11, outcome, batsman).runs_scored).to eq 3
    end
  end

  describe '#batsman_name' do
    it 'returns the batsman name' do
      outcome = double('Outcome')
      expect(batsman).to receive(:name).and_return('Some Name')
      expect(PlayedBall.new(11, outcome, batsman).batsman_name).to eq 'Some Name'
    end
  end

  describe '#out?' do
    context 'it is an out outcome' do
      it 'returns true' do
        outcome = instance_double(Outcomes::OutOutcome, out?: true)
        expect(PlayedBall.new(11, outcome, batsman).out?).to eq true
      end
    end

    context 'it is not an out outcome' do
      it 'returns false' do
        outcome = instance_double(Outcomes::EvenScoreOutcome, out?: false)
        expect(PlayedBall.new(11, outcome, batsman).out?).to eq false
      end
    end
  end

  describe '#comment' do
    context 'it is score outcome' do
      it 'returns score comment for the ball' do
        outcome = double('Outcome', out?: false, runs_scored: 1)
        expect(batsman).to receive(:name).and_return('Kirat Boli')
        actual_comment = PlayedBall.new(11, outcome, batsman).comment

        expect(actual_comment).to eq '1.5 Kirat Boli scores 1 runs'
      end
    end

    context 'it is out outcome' do
      it 'returns out comment for the ball' do
        outcome = double('Outcome', out?: true, runs_scored: 1)
        expect(batsman).to receive(:name).and_return('Kirat Boli')
        actual_comment = PlayedBall.new(11, outcome, batsman).comment

        expect(actual_comment).to eq '1.5 Kirat Boli gets out!'
      end
    end
  end

  describe '#resultant_team' do
    context 'it is the last ball of the over' do
      it 'delegates to outcome with last ball as true' do
        outcome = double('Outcome')
        expected_team = instance_double(Team)
        expect(outcome).to receive(:resultant_team)
                               .with('team name', batsman, batsman, [batsman], [batsman], true)
                               .and_return(expected_team)

        actual_team = PlayedBall.new(12, outcome, batsman).resultant_team('team name', batsman, batsman, [batsman], [batsman])

        expect(actual_team).to eq expected_team
      end
    end

    context 'it is not the last ball of the over' do
      it 'delegates to outcome with last ball as false' do
        outcome = double('Outcome')
        expected_team = instance_double(Team)
        expect(outcome).to receive(:resultant_team)
                               .with('team name', batsman, batsman, [batsman], [batsman], false)
                               .and_return(expected_team)

        actual_team = PlayedBall.new(11, outcome, batsman).resultant_team('team name', batsman, batsman, [batsman], [batsman])

        expect(actual_team).to eq expected_team
      end
    end
  end
end
