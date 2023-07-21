class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        recipes = Recipe.all
        render json: recipes
        
    end

    def create
        recipe = @user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end
    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def logged_in?
        session[:user_id].present?
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: "Signup not found" }, status: :not_found
    end
end
