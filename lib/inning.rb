class Inning
  BALLS_IN_AN_OVER = 6

  def initialize(target, overs, team)
    @target = target
    @overs = overs
    @team = team
  end

  def commentary
    runs_required_to_win = @target
    pre_inning_comment = [over_commentary(@overs.size, runs_required_to_win)]
    comments = @overs.each.with_index(1).inject(pre_inning_comment) do |comments, (over, over_number)|
      runs_required_to_win -= over.runs_scored
      end_of_over_commentary = [over_commentary(@overs.size - over_number, runs_required_to_win)]
      comments + over.comments + end_of_over_commentary
    end
    remove_final_over_comment(comments)
  end

  def result
    balls_played = @overs.inject(0) { |balls_played, over| balls_played + over.balls_played }
    balls_remaining = @overs.count * BALLS_IN_AN_OVER - balls_played
    wickets_lost = @overs.inject(0) { |wickets_lost, over| wickets_lost + over.wickets_lost }
    runs_scored = @overs.inject(0) { |runs_scored, over| runs_scored + over.runs_scored }
    if runs_scored >= @target
      "#{@team.name} won by #{@team.size - wickets_lost} wickets and #{balls_remaining} balls remaining"
    else
      "#{@team.name} lost by #{@target - runs_scored} runs"
    end
  end

  private
  def remove_final_over_comment(comments)
    comments.pop
    comments
  end

  def over_commentary(overs_left, runs_required_to_win)
    "#{overs_left} overs left. #{runs_required_to_win} runs to win"
  end
end