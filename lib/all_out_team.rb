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

  def all_out?
    true
  end
end