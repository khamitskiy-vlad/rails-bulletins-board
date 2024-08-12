# frozen_string_literal: true

module Web::Users
  class UsersController < ApplicationController
    def new
      if user_signed_in?
        redirect_to root_path, notice: 'You Already Signed' 
      else
        @user = User.new
      end
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to profile_url(@user.profile), notice: "Logged in as #{@user.name}"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
