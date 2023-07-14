require 'rails_helper'

RSpec.describe Settlement, type: :model do
  context 'validation tests' do
    first_user = User.create(name: 'Jhon', email: 'jhon123@gmail.com', password: 'password')
    before(:each) do
      first_group = Group.create(name: 'Groceries', icon: 'icon.jpg', user_id: first_user.id)
      @settlement = Settlement.create(name: 'mango', amount: 100, user_id: first_user.id,
                                      group_id: first_group.id)
    end

    it 'is invalid without a name' do
      @settlement.name = nil
      expect(@settlement).to_not be_valid
    end

    it 'is invalid without amount' do
      @settlement.amount = nil
      expect(@settlement).to_not be_valid
    end

    it 'amount must be a number' do
      @settlement.amount = 'house'
      expect(@settlement).to_not be_valid
    end

    it 'must have author ID' do
      @settlement.user_id = nil
      expect(@settlement).to_not be_valid
    end
  end
end
