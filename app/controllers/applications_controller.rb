class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

private
  def application_params
    params.require(:application).permit(:name, :street, :city, :state, :zip_code, :description, :status)
  end
end
