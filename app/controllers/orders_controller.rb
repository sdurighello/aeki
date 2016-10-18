class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.accessible_by(current_ability)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.accessible_by(current_ability)
    @order = Order.find(params[:id])
  end

  def pay_order
    @order = Order.find(params[:order_id])

    # Setup Mollie
    require 'Mollie/API/Client'
    mollie = Mollie::API::Client.new
    mollie.api_key = 'test_Gpt5CeadQ9BbGMbmAT8BzMVcNzvmFS'

    # Create payment
    if @payment = mollie.payments.create(
        amount: @order.total_price,
        description: "API payment for order id #{@order.id}",
        redirectUrl: order_url(@order)
      )
      p @payment
      redirect_to @payment.getPaymentUrl

    else
      render :show, notice: 'Something went wrong with your payment'
    end

  end

  def history
    @orders_by_user = Order.where(user: current_user)
  end

  # GET /orders/new
  def new
    @cart = session[:cart]
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # 1) check that there is a cart, else exit creation and go back to cart
    if !(session[:cart].present?)
      render :new, notice: 'Your cart is empty'
      return
    end

    # 2) get items and total price from session
    cart = session[:cart]
    cart.symbolize_keys!
    cart_items = cart[:cart_items].map(&:symbolize_keys!)
    total_price = cart[:total_price]

    # 2b) check that all products have availability, if not redirect with notice
    # ..... to-do ......

    # 3) Create and save the line items.
    def create_line_items(cart_items) # Returns array of saved line items
      line_items = []
      cart_items.each do |cart_item|
        new_line = LineItem.create(
          product_id: cart_item[:product_id],
          quantity: cart_item[:quantity],
          price: cart_item[:price]
        )
        new_line.save
        line_items << new_line
      end
      line_items
    end

    line_items = create_line_items cart_items

    # 4) Create order by putting line_items as array.
    @order = Order.new(total_price: total_price, line_items: line_items, user: current_user)

    # 5) Save order, reduce stock and redirect
    respond_to do |format|
      if @order.save
        # If order created, delete cart
        session[:cart] = nil
        # Reduce stock quantity for all products in order
        @order.line_items.each do |item|
          product = Product.find(item.product.id)
          product.quantity -= item.quantity
          product.save
        end
        # Show order
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def order_params
    #   params.require(:order).permit(:total_price, :line_items)
    # end
end
