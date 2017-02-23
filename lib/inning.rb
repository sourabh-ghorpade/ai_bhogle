class Inning
  BALLS_IN_AN_OVER = 6

  def initialize(target, overs, team)
    @target = target
    @overs = overs
    @team = team
  end

  def commentary
    runs_required_to_win = @target
    @overs.inject([]) do |comments, over|
      runs_required_to_win -= over.runs_scored
      comments + over.comments
    end
  end

  def result
    balls_played = @overs.inject(0) { |balls_played, over| balls_played + over.balls_played }
    balls_remaining = @overs.count * BALLS_IN_AN_OVER - balls_played
    wickets_lost = @overs.inject(0) { |wickets_lost, over| wickets_lost + over.wickets_lost }
    runs_scored = @overs.inject(0) { |runs_scored, over| runs_scored + over.runs_scored }
    if runs_scored > @target
      "#{@team.name} won by #{@team.size - wickets_lost} wickets and #{balls_remaining} balls remaining"
    else
      "#{@team.name} lost by #{@target - runs_scored} runs"
    end
  end
end