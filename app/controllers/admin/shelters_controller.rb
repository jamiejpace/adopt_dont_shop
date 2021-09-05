class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alph
    @applications = Application.find_pending_apps
  end
end
