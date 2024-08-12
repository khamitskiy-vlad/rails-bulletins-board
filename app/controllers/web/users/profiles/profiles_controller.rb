# frozen_string_literal: true

module Web::Users::Profiles
  class ProfilesController < ApplicationController
    def show
      @profile = set_profile
      #authorize @profile
    end

    def edit
      @profile = set_profile
      #authorize @profile
    end

    def update
      @profile = set_profile
      #authorize @profile

      if @profile.update(user_params)
        redirect_to profile_url(@profile), notice: 'Profile was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @profile = set_profile
      #authorize @profile
      
      if @profile.destroy!
        redirect_to root_url, notice: 'Profile was successfully destroyed.'
      else
        redirect_to profile_url(@profile), notice: 'Profile was successfully destroyed.'
      end
    end

    private

    def set_profile
      Profile.find(params[:id])
    end

    def user_params
      params.require(:profile).permit(:avatar, :summary)
    end
  end
end
