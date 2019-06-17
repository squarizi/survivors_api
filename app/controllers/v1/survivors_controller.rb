module V1
  class SurvivorsController < ApplicationController
    before_action :set_survivor, only: [:update_last_location, :exchange_items]
    before_action :set_exchanger, only: [:exchange_items]

    def create
      @survivor = Survivor.new(survivor_params)

      if @survivor.save
        render json: @survivor, status: :created, location: v1_survivors_url(@survivor)
      else
        render json: @survivor.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update_last_location
      return head :unprocessable_entity if survivor_not_ok?

      if @survivor.update(last_location_params)
        head :ok
      else
        render json: @survivor.errors.full_messages, status: :unprocessable_entity
      end
    end

    def exchange_items
      if exchange
        head :ok
      else
        head :unprocessable_entity
      end
    end

    private

    def set_survivor
      @survivor = Survivor.find(params[:survivor_id])
    end

    def set_exchanger
      @exchanger = Survivor.find(exchange_params.dig(:exchanger, :id))
    end

    def survivor_params
      params.require(:survivor)
            .permit(:name, :birth_date, :gender, last_location: [:lat, :lng], items:[[:item_id, :amount]])
    end

    def last_location_params
      params.require(:survivor).permit(last_location: [:lat, :lng])
    end

    def exchange_params
      params.require(:exchange).permit(items: [[:item_id, :amount]], exchanger: [ :id, items:[[:item_id, :amount]] ])
    end

    def exchange
      ExchangeMachine::Analysis.new.start @survivor, @exchanger, exchange_params
    end

    def survivor_not_ok?
      !@survivor.present? || @survivor.contaminated?
    end
  end
end
