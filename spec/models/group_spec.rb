require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'validation tests' do
    first_user = User.create(name: 'Jhon', email: 'jhon123@gmail.com', password: 'password')
    before(:each) do
      @first_group = Group.create(name: 'Groceries', icon: 'icon.jpg', user_id: first_user.id)
    end

    it 'is invalid without a name' do
      @first_group.name = nil
      expect(@first_group).to_not be_valid
    end

    it 'is invalid without an icon' do
      @first_group.icon = nil
      expect(@first_group).to_not be_valid
    end

    it 'must have a user_id' do
      @first_group.user_id = nil
      expect(@first_group).to_not be_valid
    end
  end
end
