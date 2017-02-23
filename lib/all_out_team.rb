class AllOutTeam
  attr_reader :name

  def initialize(name, out_batsmen)
    @name = name
    @out_batsmen = out_batsmen
  end

  def scores
    @out_batsmen.map(&:score)
  end

  def size
    @out_batsmen.count
  end

  def play(_, played_balls = [])
    played_balls.empty? ? UnPlayedOver.new : PlayedOver.new(played_balls)
  end
end