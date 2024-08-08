# frozen_string_literal: true

class Web::Admin::Categories::ApplicationController < Web::Admin::ApplicationController
  helper_method :resource_category

  def resource_category
    @resource_category ||= Category.find params[:category_id]
  end
end
