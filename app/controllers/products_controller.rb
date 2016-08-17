class ProductsController < ApplicationController

  def index
    @products = Product.all
    authorize! :read, @products
  end

  def show
    @product = Product.find(params[:id])
    authorize! :read, @products
  end

  def add_to_cart

    product_id = params[:product_id].to_i
    product = Product.find(product_id)

    if session[:cart]
      if session[:cart].any? { |line_item| line_item["product_id"] == product_id }
        line_item = session[:cart].find { |i| i["product_id"] == product_id }
        line_item["quantity"] += 1
        line_item["price"] = line_item["quantity"] * product.price
      else
        new_line = LineItem.new(product_id: product_id, quantity: 1, price: product.price)
        session[:cart] << new_line
      end
    else
      session[:cart] = []
      new_line = LineItem.new(product_id: product_id, quantity: 1, price: product.price)
      session[:cart] << new_line
    end

    redirect_to new_order_path

  end

  def new
    @product = Product.new
    #authorize! :create, @products
  end

  def create
    @product = Product.new( product_params )
    authorize! :create, @products

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize! :update, @products
  end

  def update
    @product = Product.find(params[:id])
    authorize! :update, @products

    if @product.update_attributes( product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @products

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
