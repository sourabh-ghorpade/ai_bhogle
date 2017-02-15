module External
  class WeightedProbabilityPicker
    def initialize(item_to_probability)
      @item_to_probability = item_to_probability
    end

    def pick
      sum = @item_to_probability.inject(0) do |sum, item_and_weight|
        sum + item_and_weight[1]
      end
      target = rand(sum)
      @item_to_probability.each do |item, weight|
        return item if target <= weight
        target -= weight
      end
    end
  end
end