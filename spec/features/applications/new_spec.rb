require 'rails_helper'

RSpec.describe "Application new page" do
  it 'has a link on the pet index page that takes you to the new application page' do
    visit '/pets'

    click_link('Start an Application')

    expect(current_path).to eq('/applications/new')
  end
end
