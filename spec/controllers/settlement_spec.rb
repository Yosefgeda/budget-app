require 'rails_helper'


RSpec.describe SettlementsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:group) { Group.create(name: 'Test Group', icon: 'link.com', user:) }
  let(:valid_attributes) { { name: 'Payment', amount: 100, user_id: user.id, group_id: group.id } }
  let(:invalid_attributes) { { name: '', amount: nil, user_id: user.id, group_id: group.id } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new settlement' do
      expect do
        post :create, params: { group_id: group.id, settlement: valid_attributes }
      end.to change(Settlement, :count).by(1)
    end
    it 'redirects to the group settlements index' do
      post :create, params: { group_id: group.id, settlement: valid_attributes }
      expect(response).to redirect_to(group_settlements_path(group))
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new settlement' do
      expect do
        post :create, params: { group_id: group.id, settlement: invalid_attributes }
      end.to_not change(Settlement, :count)
    end
  end
end
