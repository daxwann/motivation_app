require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET :new" do
    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST :create" do
    context "signin with wrong params" do
    end

    context "signin with right params" do
    end
  end

  describe "DELETE :destroy" do
    it 'logs out current user' do
    end

    it 'redirects to signin page' do
    end
  end
end
