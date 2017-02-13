class OutOutcome
  def initialize
    @runs_scored = 0
  end

  def onstrike_batsman(onstrike, nonstriker, batsmen, _)
    current_position = batsmen.find_index(onstrike)
    if batsman_at(batsmen, current_position+1) != nonstriker
      batsman_at(batsmen, current_position+1)
    else
      batsman_at(batsmen, current_position+2)
    end
  end

  def batsman_at(batsmen, position)
    batsmen[position] || NilPlayer.new
  end
end