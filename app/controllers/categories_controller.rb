class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Category was created.'
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was updated.'
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find params[:id]
    end
end