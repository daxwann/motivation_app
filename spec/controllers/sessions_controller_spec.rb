require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe "GET :new" do
    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST :create" do
    context "signin with wrong params" do
      it "validates empty params" do
        post :create, params: { user: { username: "", password: user.password } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates password shorter than 6 characters" do
        post :create, params: { user: { username: user.username, password: "" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

    context "signin with right params" do
      it "redirects to user page" do
        post :create, params: { user: { username: user.username, password: user.password } }
        expect(response).to redirect_to(user_url(User.find_by(username: user.username)))
      end
    end
  end

  describe "DELETE :destroy" do
    it 'logs out current user' do
      delete :destroy, {}
      expect(response).to redirect_to(new_session_url)
      expect(session[:session_token]).to be_nil
    end
  end
end
