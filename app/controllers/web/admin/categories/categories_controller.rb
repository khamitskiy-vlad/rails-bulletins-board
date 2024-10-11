# frozen_string_literal: true

class Web::Admin::Categories::CategoriesController < Web::Admin::Categories::ApplicationController
  include Pagy::Backend

  def index
    @search_query = set_categories
    @pagy, @categories = pagy(@search_query.result.order(created_at: :desc), items: 20)
  end

  def show
    @category = set_category
    @bulletins = @category.bulletins.includes(:creator, :category)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = set_category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_url, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = set_category

    if @category.update(category_params)
      redirect_to admin_categories_url, notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = set_category

    if @category.destroy!
      redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
    else
      redirect_to admin_categories_url, notice: "Category wasn't destroyed."
    end
  end

  private

  def set_category
    Category.find(params[:id])
  end

  def set_categories
    Category.ransack(params[:search_query])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
