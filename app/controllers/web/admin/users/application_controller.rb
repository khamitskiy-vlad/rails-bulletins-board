# frozen_string_literal: true

class Web::Admin::Users::ApplicationController < Web::Admin::ApplicationController
  helper_method :resource_user

  def resource_user
    @resource_user ||= User.find params[:user_id]
  end
end
