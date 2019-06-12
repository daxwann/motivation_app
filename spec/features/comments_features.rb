require 'rails_helper'

feature 'comments' do
  subject(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_user(user.username, user.password)
  end

  feature 'commenting on goals page' do
    scenario 'includes comments' do
    end

    scenario 'includes comment form' do
    end
  end
  
  feature 'commenting on users' do
  end
end
