# frozen_string_literal: true

module Api
  # user demographic deta
  class UsersController < ActionController::API
    before_action :set_user, :check_user_present, only: %i[show edit update destroy]
    def index
      @user = User.all
      render json: { user: @user }
    end

    def show
      render json: { user: @user }
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: { user: @user }
      else
        render json: { error_message: @user.errors.full_messages.join(', ') }
      end
    end

    def update
      if @user.update(user_params)
        render json: { user: @user, message: 'Date successfully updated' }
      else
        render json: { error_message: @user.errors.full_messages.join(', ') }
      end
    end

    def destroy
      @user.destroy
      render json: { message: 'User deleted successfully' }
    end

    def typeahead
      binding.pry
      @user = User.or(first_name: value)
                  .or(last: value)
                  .or(email: value)
      if @user.present?
        render json: { user: @user, message: 'Date successfully updated' }
      else
        render json: { message: 'Not found' }
      end
    end

   private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def check_user_present
      return render json: { error_message: "user doesn't exist" } if @user.blank?
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
