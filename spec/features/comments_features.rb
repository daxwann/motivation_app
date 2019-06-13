require 'rails_helper'

feature 'comments' do
  subject(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_user(user.username, user.password)
  end

  feature 'commenting on goals page' do
    let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

    scenario 'add and delete comment' do
      visit goal_url(goal)
      fill_in "New Comment", with: "This is the comment's body"
      click_button("Add Comment")
      expect(page).to have_content("This is the comment's body")
      click_button("Delete Comment")
      expect(page).to_not have_content("This is the comment's body")
    end
  end
  
  feature 'commenting on users' do
    let(:user2) { FactoryBot.create(:user) }

    scenario 'add and delete comment' do
      visit user_url(user2)
      fill_in "New Comment", with: "This is the comment's body"
      click_button("Add Comment")
      expect(page).to have_content("This is the comment's body")
      click_button("Delete Comment")
      expect(page).to_not have_content("This is the comment's body")
    end
  end
end
