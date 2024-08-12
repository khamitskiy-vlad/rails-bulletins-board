# frozen_string_literal: true

module Web::Users::Profiles
  class BulletinsController < ProfilesController
    before_action :authenticate_user!

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def edit
      @bulletin = set_bulletin
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      authorize @bulletin

      if @bulletin.save
        redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @bulletin = set_bulletin
      authorize @bulletin

      if user_verified?
        @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @bulletin = set_bulletin
      authorize @bulletin

      if user_verified?
        @bulletin.destroy!
        redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
      else
        redirect_to bulletine_url(@bulletin), notice: t('.failure')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, images: [])
    end

    def set_bulletin
      Bulletin.find(params[:id])
    end

    def user_verified?
      @bulletin.creator == current_user
    end
  end
end
