class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :cart_total_quantity

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def cart_total_quantity
    quantity = 0
    session[:cart]['cart_items'].each do |cart_item|
      quantity += cart_item['quantity']
    end
    quantity
  end
end
