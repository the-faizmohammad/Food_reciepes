require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :all do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @r2 = Recipe.create(user: @user, name: 'Recipe two', preparation_time: 2, cooking_time: 3,
                        description: 'Recipe two description', public: false)
    @r3 = Recipe.create(user: @user, name: 'Recipe three', preparation_time: 1, cooking_time: 1,
                        description: 'Recipe three description', public: true)
  end

  context '#create instance' do
    it 'Recipe should be valid' do
      expect(@r1).to be_valid
      expect(@r2).to be_valid
    end

    it 'User association should be present' do
      r = Recipe.create(name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
      expect(r).not_to be_valid
    end
  end

  context 'Check name validation' do
    it 'name should be present' do
      @r4 = Recipe.create(user: @user, preparation_time: 1, cooking_time: 2,
                          description: 'Recipe one description', public: true)
      expect(@r4).not_to be_valid
    end

    it 'name should be below 250 chars' do
      @r3.name = 'A' * 252
      expect(@r3).not_to be_valid
    end
  end

  context 'Check description, preparation_time, cooking_time validation' do
    it 'description should be below 2000 words' do
      r5 = Recipe.create(user: @user, name: 'Recipe 5', preparation_time: 1, cooking_time: 2,
                         description: 'Recipe one description' * 2001, public: true)
      expect(r5).not_to be_valid
    end

    it 'preparation_time should be a interger' do
      r6 = Recipe.create(user: @user, name: 'Recipe 6', preparation_time: -1, cooking_time: 2,
                         description: 'Recipe one description', public: true)
      expect(r6).not_to be_valid
    end

    it 'cooking_time should be a interger' do
      r7 = Recipe.create(user: @user, name: 'Recipe 6', preparation_time: 1, cooking_time: -1,
                         description: 'Recipe one description', public: true)
      expect(r7).not_to be_valid
    end
  end
end