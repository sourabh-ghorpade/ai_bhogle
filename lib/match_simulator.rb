class MatchSimulator
  BALLS_IN_AN_OVER = 6

  def initialize(number_of_overs, target, batting_team)
    @number_of_overs = number_of_overs
    @target = target
    @batting_team = batting_team
    @number_of_overs = number_of_overs
  end

  def simulate
    commentator = Commentator.new(@number_of_overs, @target, overs, @batting_team)
    [commentator.result] + @batting_team.scores + commentator.commentary
  end

  private
  def overs
    @number_of_overs.times.inject([]) do |overs, over_number|
      over, @batting_team = @batting_team.play(over_number + 1)
      overs << over
    end
  end
end