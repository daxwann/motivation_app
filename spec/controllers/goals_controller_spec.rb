require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user) 
    request.session[:session_token] = @user.session_token
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
      it 'renders :new' do
        post :create, params: { goal: { title: "", detail: "" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context 'submit with all params' do
      it 'redirects to goal show page' do
        post :create, params: { 
          goal: {
            title: "finish appacademy",
            detail: "Learn ruby, rails, sql, and javascript"
          }
        }
        expect(response).to redirect_to(goal_url(Goal.find_by(title: "finish appacademy")))
      end
    end
  end

  describe 'GET :show' do
    subject(:goal) { FactoryBot.create(:goal, user_id: @user.id) }
    it 'renders :show template' do
      get :show, params: { id: goal.id }
      expect(response).to render_template("show") 
    end
  end

  describe 'GET :edit' do
    subject(:goal) { FactoryBot.create(:goal, user_id: @user.id) }
    it 'renders :edit template' do
      get :edit, params: { id: goal.id }
      expect(response).to render_template("edit")
    end
  end

  describe 'PATCH :update' do
    subject(:goal) { FactoryBot.create(:goal, user_id: @user.id) }
    context 'submit with incomplete params' do
      it 're-renders edit page' do
        patch :update, params: {
          id: goal.id,
          goal: {
            title: "",
            detail: ""
         }
        }
        expect(response).to render_template("edit")
        expect(flash[:errors]).to be_present
      end
    end

    context 'submit with all params' do
      it 'redirects to goal page' do
        patch :update, params: {
          id: goal.id,
          goal: {
            title: "finish appacademy",
            details: "learn ruby, sql, rails, javascript",
            completed: true,
            public: false
          }
        }
        expect(response).to redirect_to(goal_url(goal.id))
      end
    end
  end 

  describe 'DELETE :destroy' do
    subject(:goal) { FactoryBot.create(:goal, user_id: @user.id) }
    it 'redirects to goals index' do
      id = goal.id
      delete :destroy, params: { id: id }
      expect(response).to redirect_to(goals_url)
      expect(Goal.exists?(id: id)).to be false
    end
  end
end
