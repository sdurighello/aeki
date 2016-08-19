class ProductsController < ApplicationController

  def index
    @products = Product.all.order(:name)
    authorize! :read, Product
  end

  def show
    @product = Product.find(params[:id])
    authorize! :read, Product
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    cart = session[:cart]
    if cart.present?
      cart.symbolize_keys!
      cart[:cart_items] ||= []
      cart[:cart_items].map(&:symbolize_keys!)
      cart[:total_price] ||= 0

      cart[:cart_items].delete_if { |item| item[:product_id] == product_id}
    end
    if cart[:cart_items].empty?
      cart = nil
    end
    session[:cart] = cart
    redirect_to new_order_path
  end

  def add_to_cart

    # session: {
      # :cart => {
        # :cart_items: [ {} ],
        # :total_price: ...
      # }
    # }

    quantity = params[:quantity].to_i
    product_id = params[:product_id].to_i
    product = Product.find(product_id)
	  authorize! :add_to_cart, @products

    cart = session[:cart] || {}
    cart.symbolize_keys!
    cart[:cart_items] ||= []
    cart[:cart_items].map(&:symbolize_keys!)
    cart[:total_price] ||= 0

    cart_item = cart[:cart_items].find { |i| i[:product_id] == product.id }

    def product_stock_empty?(product, cart_item, quantity)
      if cart_item.present?
        (product.quantity - (cart_item[:quantity] + quantity)) < 0
      else
        (product.quantity - quantity) < 0
      end
    end

    def cart_item_empty?(product, cart_item, quantity)
      if cart_item.present?
        (cart_item[:quantity] + quantity) < 1
      else
        false
      end
    end

    if product_stock_empty?(product, cart_item, quantity)
      redirect_to new_order_path, notice: "No stock available for this product" and return
    end

    if cart_item_empty?(product, cart_item, quantity)
      redirect_to new_order_path, notice: "Cart item quantity must be > 1. Remove item if not needed" and return
    end

    if cart[:cart_items].any? { |item| item[:product_id] == product_id }
      item = cart[:cart_items].find { |i| i[:product_id] == product_id }
      item[:quantity] += quantity
      item[:price] = item[:quantity] * product.price
    else
      new_line = LineItem.new(product_id: product_id, quantity: quantity, price: product.price)
      cart[:cart_items] << new_line
    end

    def calculate_total_price(cart_items)
      total = 0
      cart_items.each do |item|
        total = total + item[:price].to_f
      end
      total
    end

    cart[:total_price] = calculate_total_price cart[:cart_items]

    session[:cart] = cart

    redirect_to new_order_path

  end

  def new
    @product = Product.new
    authorize! :create, @products
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
      params.require( :product ).permit( :name, :description, :image, :price, inventory_attributes: [ :quantity ] )
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
