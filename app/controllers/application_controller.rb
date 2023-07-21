class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  before_action :authorized

  private

  def authorized
    @user = User.find_by(id: session[:user_id])
    return render json: {errors: ["Not Authorized"]}, status: :unauthorized unless @user
  end

  def unprocessable_entity(error)
    render json: {errors: [error.record.errors.full_messages]}, status: :unprocessable_entity
  end
end
