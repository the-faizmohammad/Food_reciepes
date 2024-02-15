require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Login GET /sign_in' do
    before :each do
      get new_user_session_path
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render sessions/new view' do
      expect(response).to render_template(:new)
    end

    it 'should render placeholder from new view' do
      expect(response.body).to include('Log in')
    end
  end

  describe 'Signup GET /sign_up' do
    before :each do
      get new_user_registration_path
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render sessions/new view' do
      expect(response).to render_template(:new)
    end

    it 'should render placeholder from new view' do
      expect(response.body).to include('Sign up')
    end
  end
end