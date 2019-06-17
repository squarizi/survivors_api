class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  protected

  def not_found
    head :not_found
  end

  def missing_param_error(exception)
    render status: :unprocessable_entity, json: { error: exception.message }
  end
end
