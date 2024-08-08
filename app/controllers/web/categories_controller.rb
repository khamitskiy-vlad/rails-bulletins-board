# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def show
    @category = set_category
    authorize @category
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
