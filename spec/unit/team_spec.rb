require 'spec_helper'

describe Team do
  let(:striker) { instance_double(Batsman, score: 'B1 - 2 (6 balls)') }
  let(:non_striker) { instance_double(Batsman, score: 'B2 - 15 (6 balls)') }
  let(:another_batsman) { instance_double(Batsman, score: 'B3 - 10 (6 balls)') }
  let(:out_batsmen) { [instance_double(Batsman, score: 'B4 - 8 (4 balls)')] }
  let(:yet_to_play_batsmen) { [another_batsman] }
  let(:team) { Team.new('Lengaburu', striker, non_striker, yet_to_play_batsmen, out_batsmen) }

  describe '#play' do
    it 'returns returns outcome of playing the ball and resultant team' do
      updated_striker = double(Batsman)
      played_balls_count = 1
      ball_number = 1
      currently_played_ball = instance_double(PlayedBall)
      expect(striker).to receive(:play)
                             .with(played_balls_count)
                             .and_return([currently_played_ball, updated_striker])
      ball_played_team = double('Team')
      expect(currently_played_ball).to receive(:resultant_team)
                                           .with('Lengaburu', updated_striker, non_striker,
                                                 yet_to_play_batsmen, out_batsmen)
                                           .and_return(ball_played_team)

      actual_played_ball, actual_team = team.play(ball_number)

      expect(actual_played_ball).to eq currently_played_ball
      expect(actual_team).to eq ball_played_team
    end
  end

  describe '#all_out?' do
    it 'returns true' do
      expect(team).not_to be_all_out
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