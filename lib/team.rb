class Team
  attr_reader :name
  def initialize(name, striker, non_striker, yet_to_play_batsmen, out_batsmen)
    @name = name
    @striker = striker
    @non_striker = non_striker
    @yet_to_play_batsmen = yet_to_play_batsmen
    @out_batsmen = out_batsmen
  end

  def scores
    all_batsmen.map(&:score)
  end

  def size
    all_batsmen.count
  end

  def play(is_last_ball)
    outcome, updated_striker = @striker.play
    return outcome, outcome.resultant_team(@name, updated_striker, @non_striker, @yet_to_play_batsmen, @out_batsmen, is_last_ball)
  end

  private
  def all_batsmen
    ([@striker, @non_striker] + @yet_to_play_batsmen + @out_batsmen)
  end
end