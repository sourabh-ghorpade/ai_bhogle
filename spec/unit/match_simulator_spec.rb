require 'spec_helper'

describe MatchSimulator do
  let(:team) { instance_double(Team, all_out?: false)}

  describe '#simulate' do
    context 'the target is achieved with playing all the balls' do
      it 'returns match result with all the overs' do
        number_of_overs = 2
        balls_in_an_over = 6
        target = 40
        number_of_balls = number_of_overs * balls_in_an_over
        played_ball = instance_double(PlayedBall, runs_scored: 1)
        over = instance_double(PlayedOver)
        1...number_of_balls.times do |ball_number|
          expect(team).to receive(:play).with(ball_number + 1).and_return([played_ball, team])
        end
        expect(PlayedOver).to receive(:new)
                                  .with(0, [played_ball, played_ball, played_ball, played_ball, played_ball, played_ball])
                                  .and_return(over)

        expect(PlayedOver).to receive(:new)
                                  .with(1, [played_ball, played_ball, played_ball, played_ball, played_ball, played_ball])
                                  .and_return(over)
        played_overs = [over]
        commentator = instance_double(Inning)
        expect(Inning).to receive(:new).with(target, array_including(played_overs), team).and_return(commentator)
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

    context 'the target is not achieved with playing all the balls' do
      context 'team wins' do
        it 'returns match result with lesser overs' do
          number_of_overs = 2
          target = 2
          played_ball = instance_double(PlayedBall, runs_scored: 1)
          over = instance_double(PlayedOver)
          2.times do |ball_number|
            expect(team).to receive(:play).with(ball_number + 1).and_return([played_ball, team])
          end
          expect(PlayedOver).to receive(:new)
                                    .with(0, [played_ball, played_ball])
                                    .and_return(over)
          played_overs = [over]
          commentator = instance_double(Inning)
          expect(Inning).to receive(:new).with(target, array_including(played_overs), team).and_return(commentator)
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

      context 'team is all out' do
        it 'returns match result with lesser overs' do
          number_of_overs = 2
          target = 2
          played_ball = instance_double(PlayedBall, runs_scored: 0)
          over = instance_double(PlayedOver)
          team = instance_double(Team)
          expect(team).to receive(:all_out?).and_return(true)
          expect(team).to receive(:play).with(1).and_return([played_ball, team])
          expect(PlayedOver).to receive(:new)
                                    .with(0, [played_ball])
                                    .and_return(over)
          played_overs = [over]
          commentator = instance_double(Inning)
          expect(Inning).to receive(:new).with(target, array_including(played_overs), team).and_return(commentator)
          commentary = ['0.1 Kirat Boli gets out!']
          expect(commentator).to receive(:commentary).and_return(commentary)
          result = 'Lengaburu loses by 2 runs'
          expect(commentator).to receive(:result).and_return(result)
          final_score_card = ['Kirat Boli - 0 (6 balls)']
          expect(team).to receive(:scores).and_return(final_score_card)

          actual_result = MatchSimulator.new(number_of_overs, target, team).simulate

          expect(actual_result).to eq [result] + final_score_card + commentary
        end
      end
    end
  end
end