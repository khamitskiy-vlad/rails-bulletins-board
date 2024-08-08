# frozen_string_literal: true

class Web::Admin::Categories::BulletinsController < Web::Admin::Categories::CategoriesController
  include Pagy::Backend

  def index
    @category = resource_category
    @bulletins_count = @category.bulletins.size
    @search_query = @category.bulletins.ransack(params[:search_query])
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category),
                                          items: 20)
  end
end
