class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
    @profile.user = current_user
    @profile.save
    authorize! :create, @profile
  end
end
