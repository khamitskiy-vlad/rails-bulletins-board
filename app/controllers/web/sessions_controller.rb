class Web::SessionsController < Web::ApplicationController
  def new
    redirect_to root_path, notice: 'You Already Signed' if user_signed_in?
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to profile_url(@user.profile), notice: "Logged in as #{@user.name}"
    else
      redirect_to new_session_path, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end
end
