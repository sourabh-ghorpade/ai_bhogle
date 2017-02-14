require 'spec_helper'
require 'team'
require 'batsman'
require 'outcomes/out_outcome'
require 'outcomes/score_outcome'

describe Team do
  describe '#play' do
    context 'result is an out outcome' do
      it 'returns returns outcome of playing the ball and puts a new batsman on strke' do
        striker = instance_double(Batsman)
        non_striker = instance_double(Batsman)
        another_batsman = instance_double(Batsman)
        batsmen = [striker, non_striker, another_batsman]
        out_outcome = instance_double(OutOutcome)
        expect(out_outcome).to receive(:out?).and_return(true)
        expect(striker).to receive(:play).and_return(out_outcome)
        team = Team.new(batsmen)
        updated_team = instance_double(Team)
        expect(Team).to receive(:new).with(batsmen, another_batsman, non_striker).and_return(updated_team)

        actual_outcome, actual_team = team.play(true)

        expect(actual_outcome).to eq out_outcome
        expect(actual_team).to eq updated_team
      end
    end

    context 'result is a score outcome' do
      context 'it is the last ball of the over' do
        context 'score results in strike change' do
          it 'returns outcome of playing the ball and self' do
            striker = instance_double(Batsman)
            non_striker = instance_double(Batsman)
            another_batsman = instance_double(Batsman)
            batsmen = [striker, non_striker, another_batsman]
            score_outcome = instance_double(ScoreOutcome)
            expect(score_outcome).to receive(:out?).and_return(false)
            expect(score_outcome).to receive(:strike_change?).and_return(true)
            expect(striker).to receive(:play).and_return(score_outcome)
            team = Team.new(batsmen)

            actual_outcome, actual_team = team.play(true)

            expect(actual_outcome).to eq score_outcome
            expect(actual_team).to eq team
          end
        end

        context 'score does not result in strike change' do
          it 'returns outcome of playing the ball and stike rotated team' do
            striker = instance_double(Batsman)
            non_striker = instance_double(Batsman)
            batsmen = [striker, non_striker]
            score_outcome = instance_double(ScoreOutcome)
            expect(score_outcome).to receive(:out?).and_return(false)
            expect(score_outcome).to receive(:strike_change?).and_return(false)
            expect(striker).to receive(:play).and_return(score_outcome)
            team = Team.new(batsmen)

            strike_rotated_team = instance_double(Team)
            expect(Team).to receive(:new).with(batsmen, non_striker, striker).and_return(strike_rotated_team)
            actual_outcome, actual_updated_team = team.play(true)

            expect(actual_outcome).to eq score_outcome
            expect(actual_updated_team).to eq strike_rotated_team
          end
        end
      end

      context 'it is not the last ball of the over' do
        context 'score results in strike change' do
          it 'returns outcome of playing the ball and stike rotated team' do
            striker = instance_double(Batsman)
            non_striker = instance_double(Batsman)
            another_batsman = instance_double(Batsman)
            batsmen = [striker, non_striker, another_batsman]
            score_outcome = instance_double(ScoreOutcome)
            expect(score_outcome).to receive(:out?).and_return(false)
            expect(score_outcome).to receive(:strike_change?).and_return(true)
            expect(striker).to receive(:play).and_return(score_outcome)
            team = Team.new(batsmen)

            strike_rotated_team = instance_double(Team)
            expect(Team).to receive(:new).with(batsmen, non_striker, striker).and_return(strike_rotated_team)
            actual_outcome, actual_updated_team = team.play(false)

            expect(actual_outcome).to eq score_outcome
            expect(actual_updated_team).to eq strike_rotated_team
          end
        end

        context 'score does not result in strike change' do
          it 'returns outcome of playing the ball and self' do
            striker = instance_double(Batsman)
            non_striker = instance_double(Batsman)
            another_batsman = instance_double(Batsman)
            batsmen = [striker, non_striker, another_batsman]
            score_outcome = instance_double(ScoreOutcome)
            expect(score_outcome).to receive(:out?).and_return(false)
            expect(score_outcome).to receive(:strike_change?).and_return(false)
            expect(striker).to receive(:play).and_return(score_outcome)
            team = Team.new(batsmen)

            actual_outcome, actual_team = team.play(false)

            expect(actual_outcome).to eq score_outcome
            expect(actual_team).to eq team
          end
        end
      end
    end
  end
end