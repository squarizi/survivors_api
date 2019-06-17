module V1
  class ComplaintsController < ApplicationController
    def create
      @complaint = Complaint.new(complaint_params)

      if @complaint.save
        render json: @complaint, status: :created, location: v1_complaints_url(@complaint)
      else
        render json: @complaint.errors.full_messages, status: :unprocessable_entity
      end
    end

    private

    def complaint_params
      params.require(:complaint).permit(:complainer_id, :contaminated_id)
    end
  end
end
