require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe 'GET :new' do
    it 'returns :new template' do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe 'POST :create' do
    context 'sign up with incorrect params' do
      it "validates the presence of user's email and password" do
        post :create, params: { user: { username: "", password: "starwars" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates the length of password to be at least 6 characters" do
        post :create, params: { user: { username: "andyruiz", password: "abc" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context 'sign up with correct params' do
      it "redirects user to user page" do
        post :create, params: { user: { username: "jwick", password: "starwars" } }
        expect(response).to redirect_to(user_url(User.find_by(username: "jwick")))
      end
    end
  end

  describe 'GET :index' do
    before(:each) do
      post :create, params: { user: { username: "jwick", password: "starwars" } }
    end
    it 'returns :index template' do
      get :index
      expect(response).to render_template("index")
    end
  end
end
