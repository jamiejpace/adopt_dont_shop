class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search_by_pet_name].present?
      @pets = Pet.search(params[:search_by_pet_name])
    else
      @pets = []
    end
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

  def edit
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{application.id}"
  end

private
  def application_params
    params.require(:application).permit(:name, :street, :city, :state, :zip_code, :description, :status)
  end
end
