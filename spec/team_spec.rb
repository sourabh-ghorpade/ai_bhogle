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
    it 'returns returns outcome of playing the ball and resultant team' do
      updated_striker = double(Batsman)
      ball_number = 0
      expected_played_ball = instance_double(PlayedBall)
      expect(striker).to receive(:play).with(ball_number).with(ball_number).and_return([expected_played_ball, updated_striker])
      expected_resultant_team = instance_double(Team)
      expect(expected_played_ball).to receive(:resultant_team)
                             .with('Lengaburu', updated_striker, non_striker, yet_to_play_batsmen, out_batsmen)
                             .and_return(expected_resultant_team)

      actual_played_ball, actual_team = team.play(ball_number)

      expect(actual_played_ball).to eq expected_played_ball
      expect(actual_team).to eq expected_resultant_team
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