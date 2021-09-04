class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.create(application_params)
    require 'pry'; binding.pry
    if application.id.nil?
      redirect_to "/applications/new"
    else
      redirect_to "/applications/#{application.id}"
    end
  end

private
  def application_params
    params.require(:application).permit(:name, :street, :city, :state, :zip_code, :description, :status)
  end
end
