class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
#this is actually updating a pet application
  def update
    pet_application = PetApplication.find_by(id: params[:id])
    pet_application.update(application_status: params[:application_status])
    pet_application.application.update_status
    redirect_to "/admin/applications/#{pet_application.application.id}"
  end
end
