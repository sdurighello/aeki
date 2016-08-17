class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart

    session[:cart] = [] if !session[:cart]
    new_item = {}
    new_item[:product_id] = params[:cart_item]
    new_item[:quantity] = 1
    session[:cart] << new_item
    redirect_to new_order_path

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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes( product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    redirect_to products_path
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
