# frozen_string_literal: true

class Web::Admin::Users::BulletinsController < Web::Admin::Users::UsersController
  include Pagy::Backend

  def index
    @user = resource_user
    @bulletins_count = @user.bulletins.size
    @search_query = @user.bulletins.ransack(params[:search_query])
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category),
                             items: 20)
  end
end
