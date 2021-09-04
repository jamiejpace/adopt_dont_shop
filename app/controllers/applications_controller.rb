class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.create(application_params)
    if application.id.nil?
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    else
      redirect_to "/applications/#{application.id}"
    end
  end

private
  def application_params
    params.require(:application).permit(:name, :street, :city, :state, :zip_code, :description, :status)
  end
end
