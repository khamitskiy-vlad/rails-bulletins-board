# frozen_string_literal: true

module Web::Users
  class UsersController < ApplicationController
    def show
      @user = set_user
      # authorize @user
    end

    def new
      if user_signed_in?
        redirect_to root_path, notice: 'You Already Signed'
      else
        @user = User.new
      end
    end

    def edit
      @user = set_user
      # authorize @user
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to user_url(@user), notice: "Logged in as #{@user.name}"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def profile
      @user = set_user
      # authorize @user
    end

    def update
      @user = set_user
      # authorize @user

      if @user.update(user_params)
        redirect_to user_url(@user), notice: 'user was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = set_user
      # authorize @user

      if @user.destroy!
        redirect_to root_url, notice: 'user was successfully destroyed.'
      else
        redirect_to user_url(@user), notice: 'user was successfully destroyed.'
      end
    end

    private

    def set_user
      User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
