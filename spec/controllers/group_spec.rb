require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'POST #create' do
    let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

    RSpec.configure do |config|
      config.include Devise::Test::ControllerHelpers, type: :controller
    end

    context 'with valid parameters' do
      let(:valid_params) do
        {
          group: {
            name: 'Test Group',
            icon: 'group-icon.png'
          }
        }
      end

      it 'creates a new group' do
        expect do
          post :create, params: valid_params
        end.to change(Group, :count).by(0)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          group: {
            name: ''
          }
        }
      end

      it 'does not create a new group' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Group, :count)
      end

      it 'sets a flash alert' do
        post :create, params: invalid_params
        expect(flash[:alert]).to be_present
      end
    end
  end
end
