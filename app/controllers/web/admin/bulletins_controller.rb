# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  include Pagy::Backend

  def index
    @bulletins_count = Bulletin.all.size
    @search_query = set_bulletins
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category),
                                          items: 20)
  end

  def show
    @bulletin = set_bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = set_bulletin
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)

    if @bulletin.save
      redirect_to admin_bulletin_url(@bulletin), notice: 'Bulletin was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = set_bulletin

    if @bulletin.update(bulletin_params)
      redirect_to admin_bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = set_bulletin

    if @bulletin.destroy!
      redirect_to admin_bulletins_url, notice: 'Bulletin was successfully destroyed.'
    else
      redirect_to admin_bulletine_url(@bulletin), notice: t('.failure')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :creator_id, :image)
  end

  def set_bulletin
    Bulletin.find(params[:id])
  end

  def set_bulletins
    Bulletin.ransack(params[:search_query])
  end
end
