require 'spec_helper'
require 'team'
require 'batsman'
require 'played_ball'
require 'outcomes/out_outcome'
require 'outcomes/even_score_outcome'

describe Team do
  let(:striker) { instance_double(Batsman, score: 'B1 - 2 (6 balls)') }
  let(:non_striker) { instance_double(Batsman, score: 'B2 - 15 (6 balls)') }
  let(:another_batsman) { instance_double(Batsman, score: 'B3 - 10 (6 balls)') }
  let(:out_batsmen) { [instance_double(Batsman, score: 'B4 - 8 (4 balls)')] }
  let(:yet_to_play_batsmen) { [another_batsman] }
  let(:team) { Team.new('Lengaburu', striker, non_striker, yet_to_play_batsmen, out_batsmen) }

  describe '#play' do
    context 'over is ongoing' do
      it 'returns returns outcome of playing the ball and resultant team' do
        updated_striker = double(Batsman)
        already_played_balls = [instance_double(PlayedBall)]
        played_balls_count = 1
        over_number = 1
        currently_played_ball = instance_double(PlayedBall)
        expect(striker).to receive(:play)
                               .with(played_balls_count + 1)
                               .and_return([currently_played_ball, updated_striker])
        ball_played_team = double('Team')
        expect(currently_played_ball).to receive(:resultant_team)
                                            .with('Lengaburu', updated_striker, non_striker,
                                                  yet_to_play_batsmen, out_batsmen)
                                            .and_return(ball_played_team)
        full_over_played_team = double('Team')
        expected_played_over = instance_double(Over)
        expect(ball_played_team).to receive(:play)
                                        .with(over_number, already_played_balls + [currently_played_ball])
                                        .and_return([expected_played_over, full_over_played_team])

        actual_played_over, actual_team = team.play(over_number, already_played_balls)

        expect(actual_played_over).to eq expected_played_over
        expect(actual_team).to eq full_over_played_team
      end
    end

    context 'over has ended' do
      it 'returns returns outcome of playing the ball and resultant team' do
        over_number = 1
        six_played_balls = [instance_double(PlayedBall), instance_double(PlayedBall), instance_double(PlayedBall),
                             instance_double(PlayedBall), instance_double(PlayedBall), instance_double(PlayedBall)]

        expected_played_over = instance_double(Over)
        expect(Over).to receive(:new).with(six_played_balls).and_return(expected_played_over)
        played_over, actual_team = team.play(over_number, six_played_balls)

        expect(played_over).to eq expected_played_over
        expect(actual_team).to eq team
      end
    end
  end

  describe '#scores' do
    it 'returns scores of all batsmen' do
      expected_scores = ['B1 - 2 (6 balls)', 'B2 - 15 (6 balls)', 'B3 - 10 (6 balls)', 'B4 - 8 (4 balls)']

      actual_scores = team.scores

      expect(actual_scores).to eq expected_scores
    end
  end

  describe '#size' do
    it 'returns the size of the team' do
      actual_size = team.size

      expect(actual_size).to eq 4
    end
  end

  describe '#name' do
    it 'returns the name of the team' do
      expect(team.name).to eq 'Lengaburu'
    end
  end
end