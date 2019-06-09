require 'rails_helper'

feature 'authentication' do
subject(:user) { FactoryBot.build(:user) }

feature 'sign up process' do
  scenario 'has new user page' do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature 'creates a new user' do
    scenario 'invalidates wrong params' do
      sign_up_user(nil, nil)

      expect(current_path).to eq("/users")
      expect(page).to have_content("Password is too short")
      expect(page).to have_content("Username can't be blank")
    end

    scenario 'creates new user with correct params' do
      sign_up_user(user.username, user.password)

      expect(current_path).to eq("/users")
      expect(page).to have_content(user.username)
    end
  end
end

feature 'sign in process' do
  scenario 'has sign in page' do
    visit new_session_url
    expect(page).to have_content("Login")
  end

  feature 'signing in to new session' do
    scenario 'invalidates wrong params' do
      login_user(nil, nil)
      expect(current_path).to eq("/session")
      expect(page).to have_content("Incorrect username or password")
    end

    scenario 'creates new session with correct params' do
      user.save!
      login_user(user.username, user.password)
      expect(current_path).to eq("/users")
      expect(page).to have_content(user.username)
    end
  end
end

feature 'sign out process' do
  before(:each) do 
    user.save!
    login_user(user.username, user.password) 
  end

  scenario 'begins with a logged out state' do
    click_button("Logout")
    expect(current_path).to eq("/session/new")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_button("Logout")
    expect(page).to_not have_content(user.username)
  end
end
end
