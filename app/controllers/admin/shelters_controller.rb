class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alph
  end
end
