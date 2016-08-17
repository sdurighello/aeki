class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new( product_params )

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end


  private

    def product_params
      params.require( :product ).permit( :name, :description, :image, :price )
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
