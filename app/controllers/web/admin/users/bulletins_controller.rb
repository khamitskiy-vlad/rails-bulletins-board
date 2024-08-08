# frozen_string_literal: true

class Web::Admin::Users::BulletinsController < Web::Admin::Users::UsersController
  include Pagy::Backend

  def index
    @user = resource_user
    @search_query = set_bulletins
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category),
                                          items: 20)
  end

  private

  def set_bulletins
    resource_user.bulletins.ransack(params[:search_query])
  end
end
