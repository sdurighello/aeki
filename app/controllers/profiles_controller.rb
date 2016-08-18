class ProfilesController < ApplicationController
  load_and_authorize_resource

  def user_list
    @users = User.all.order(:email)
  end

  def index
    authorize! :create, @profile
  end

  def new
    @profile = Profile.new
    @profile.user = current_user
    @profile.save
    authorize! :create, @profile
  end

  def show
  end

  def create
    profile_params

    @profile = Profile.new( profile_params )

    if @profile.save
       render 'root'
    else
       render 'new'
    end

  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update

    @profile = Profile.find( params[:id] )

    profile_params


    if @profile.update_attributes( profile_params )
      redirect_to products_path
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require( :profile ).permit( :first_name, :surname, :addr_street, :addr_postcode, :addr_town, :gender )
  end

end
