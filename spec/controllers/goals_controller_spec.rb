require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  before(:each) do
    user = FactoryBot.create(:user)
    request.session[:session_token] = user.session_token
  end

  describe 'GET :index' do
    it 'renders index page when logged in' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET :new' do
    it 'renders :new template' do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'POST :create' do
    context 'submit with incomplete params' do
    end

    context 'submit with all params' do
    end
  end

  describe 'GET :show' do
    it 'renders :show template' do
    end
  end

  describe 'GET :edit' do
    it 'renders :edit template' do
    end
  end

  describe 'POST :update' do
    context 'submit with incomplete params' do
    end

    context 'submit with all params' do
    end
  end

  describe 'DELETE :destroy' do
    it 'redirects to goals index' do
    end
  end
end
