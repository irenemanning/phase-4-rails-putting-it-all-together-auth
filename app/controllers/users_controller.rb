class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # /me
    def show
        user = User.find_by(username: params[:username])
        if session[:user_id] = user.id
            render json: user
        end
    end

    #signup
    def create
        user = User.create(user_params)
        if user.valid?
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: "Signup not found" }, status: :not_found
    end

end
