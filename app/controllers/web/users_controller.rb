# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  def show
    @user = set_user
    authorize @user
  end

  def edit
    @user = set_user
    authorize @user
  end

  def update
    @user = set_user
    authorize @user

    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = set_user
    authorize @user
    
    if @user.destroy!
      redirect_to root_url, notice: 'User was successfully destroyed.'
    else
      redirect_to user_url(@user), notice: 'User was successfully destroyed.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
