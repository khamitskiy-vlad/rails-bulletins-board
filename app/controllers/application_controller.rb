# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  after_action :verify_authorized
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_signed_in?
  rescue_from(
    Pundit::NotAuthorizedError,
    Pundit::AuthorizationNotPerformedError,
    with: :user_not_authorized
  )

  private

  def authenticate_user!
    redirect_to root_path, alert: 'Requires authentication' unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def user_not_authorized
    redirect_to root_path, alert: 'Requires authorization' && return
  end
end
