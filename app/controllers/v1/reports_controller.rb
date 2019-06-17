module V1
  class ReportsController < ApplicationController
    include ManagmentInformationsHelper

    def index
      render json: informations
    end

    private

    def informations
      {
        cronenbergeds_percentage_survivors: cronenbergeds_porcentage,
        clean_percentage_survivors: clean_percentage,
        average_items_survivor: {
          ammunitions: items_count(:ammunitions),
          medicines: items_count(:medicines),
          foods: items_count(:foods),
          waters: items_count(:waters)
        },
        lost_points: lost_points
      }
    end
  end
end
