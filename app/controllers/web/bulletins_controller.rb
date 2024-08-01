# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  include Pagy::Backend

  def index
    @search_query = set_bulletins
    @pagy, @bulletins = pagy(@search_query.result
                                          .order(created_at: :desc)
                                          .includes(:creator, :category))
  end

  def show
    @bulletin = set_bulletin
    @creator = @bulletin.creator
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = set_bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = set_bulletin

    if user_verified? 
      @bulletin.update(bulletin_params)
      redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = set_bulletin

    if user_verified?
      @bulletin.destroy!
      redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
    else
      redirect_to bulletine_url(@bulletin), notice: t('.failure')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
  
  def set_bulletins
    Bulletin.ransack(params[:search_query])
  end

  def user_verified?
    @bulletin.creator == current_user
  end
end
