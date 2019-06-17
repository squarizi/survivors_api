module ExchangeMachine
  class Analysis
    def start(survivor, exchanger, exchange_params)
      @survivor = survivor
      @exchanger = exchanger
      @params = exchange_params

      return false if exchange_not_permited?

      exchange_items
    end

    private

    def exchange_not_permited?
      contaminated? || !same_points?
    end

    def contaminated?
      @survivor.contaminated? || @exchanger.contaminated?
    end

    def same_points?
       survivor_item_points == exchanger_item_points
    end

    def survivor_item_points
      sum_item_points(@params.dig(:items))
    end

    def exchanger_item_points
      sum_item_points(@params.dig(:exchanger, :items))
    end

    def sum_item_points(items)
      items.map.inject(0) { |sum, item| sum + (item[:item_id] * item[:amount]) }
    end

    def exchange_items
      @survivor.remove_items!(@params.dig(:items))
      @exchanger.include_items!(@params.dig(:items))

      @exchanger.remove_items!(@params.dig(:exchanger, :items))
      @survivor.include_items!(@params.dig(:exchanger, :items))
    end
  end
end
