# frozen_string_literal: true

class Web::Admin::Users::UsersController < Web::Admin::Users::ApplicationController
  include Pagy::Backend

  def index
    @search_query = set_users
    @pagy, @users = pagy(@search_query.result
                                      .includes(:bulletins),
                                      items: 20)
  end

  def show
    @user = set_user
    @bulletins = @user.bulletins.includes(:creator, :category)
  end

  def new
    @user = User.new
  end

  def edit
    @user = set_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = set_user

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = set_user
    
    if @user.destroy!
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    else
      redirect_to admin_users_url, notice: "User wasn't destroyed."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    User.ransack(params[:search_query])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
