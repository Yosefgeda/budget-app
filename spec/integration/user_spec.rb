require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Groups', type: :feature do
  include Capybara::DSL
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  before do
    sign_in user
  end

  describe 'Group view' do
    it 'displays a message when user has no groups' do
      visit groups_path

      expect(page).to have_selector('.no-data', text: 'You have no groups yet.')
      expect(page).to_not have_selector('.group')
    end

    it 'redirects to the new group form when clicking "ADD GROUP" button' do
      visit groups_path

      click_link 'ADD GROUP'

      expect(page).to have_current_path(new_group_path)
    end
  end
end
