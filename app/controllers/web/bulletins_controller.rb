# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  include Pagy::Backend

  def index
    @search_query = set_bulletins
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category))
    authorize @bulletins
  end

  def show
    @bulletin = set_bulletin
    authorize @bulletin
    @creator = @bulletin.creator
  end

  private

  def set_bulletin
    Bulletin.find(params[:id])
  end

  def set_bulletins
    Bulletin.ransack(params[:search_query])
  end
end
