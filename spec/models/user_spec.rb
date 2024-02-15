require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
  end

  context '#create instance' do
    it 'User should be valid' do
      @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
      expect(@user).to be_valid
    end

    it 'name should be present' do
      @user = User.create(surname: 'Spec', password: 'testing')
      expect(@user).not_to be_valid
    end

    it 'email should be present' do
      @user = User.create(name: 'User', surname: 'Spec', password: 'testing')
      expect(@user).not_to be_valid
    end
  end
end