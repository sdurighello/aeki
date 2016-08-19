class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :cart_total_quantity
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def cart_total_quantity
    if session[:cart].present?
      quantity = 0
      session[:cart]['cart_items'].each do |cart_item|
        quantity += cart_item['quantity']
      end
      quantity
    else
      quantity = 0
    end
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit( :email, :password, :password_confirmation, profile_attributes: [ :first_name, :surname, :addr_street, :addr_postcode, :addr_town, :gender ] )
    end

  end

end
