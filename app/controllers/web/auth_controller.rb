# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_url(@user), notice: "Logged in as #{@user.name}"
    else
      redirect_to root_url, alert: 'Failure'
    end
  end

  def failure
    redirect_to root_path, alert: 'Failure'
  end
end
