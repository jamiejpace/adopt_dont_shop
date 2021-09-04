class PetApplicationsController < ApplicationController
  def new
  end

  def create
    pet_app = PetApplication.create(pet_application_params)
    redirect_to "/applications/#{pet_app.application_id}"
  end

private
  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end
