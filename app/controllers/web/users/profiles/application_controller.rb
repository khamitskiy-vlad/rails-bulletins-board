# frozen_string_literal: true

module Web::Users
  class Profiles::ApplicationController < ApplicationController
    helper_method :resource_user

    def resource_user
      @resource_user ||= User.find params[:user_id]
    end
  end
end
