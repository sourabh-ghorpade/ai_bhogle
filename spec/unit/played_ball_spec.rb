require 'spec_helper'

describe PlayedBall do
  let(:batsman) { instance_double(Batsman, name: 'Kirat Boli') }
  let(:outcome) { instance_double('Outcome') }

  describe '#comment' do
    context 'it is score outcome' do
      it 'returns score comment for the ball' do
        outcome = double('Outcome', out?: false, runs_scored: 1)
        expect(batsman).to receive(:name).and_return('Kirat Boli')
        actual_comment = PlayedBall.new(11, outcome, batsman).comment

        expect(actual_comment).to eq 'Kirat Boli scores 1 runs'
      end
    end

    context 'it is out outcome' do
      it 'returns out comment for the ball' do
        outcome = double('Outcome', out?: true,)
        expect(batsman).to receive(:name).and_return('Kirat Boli')
        actual_comment = PlayedBall.new(11, outcome, batsman).comment

        expect(actual_comment).to eq 'Kirat Boli gets out!'
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
