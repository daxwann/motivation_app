require 'rails_helper'

feature 'comments' do
  subject(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_user(user.username, user.password)
  end

  feature 'commenting on goals page' do
    let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

    scenario 'add comment' do
      visit goal_url(goal)
      fill_in "New Comment", with: "This is the comment's body"
      click_button("Add Comment")
      expect(page).to have_content("This is the comment's body") 
    end

    scenario 'delete comment' do
      goal_comment = FactoryBot.create(:goal_comment, goal_id: goal.id, author_id: user.id)
      visit goal_url(goal)
      expect(page).to have_content(goal_comment.body)
      click_button("Delete Comment")
      expect(page).to_not have_content(goal_comment.body)
    end
  end
  
  feature 'commenting on users' do
    let(:user2) { FactoryBot.create(:user) }

    scenario 'add comment' do
      visit user_url(user2)
      fill_in "New Comment", with: "This is the comment's body"
      click_button("Add Comment")
      expect(page).to have_content("This is the comment's body")
    end

    scenario 'delete comment' do
      user_comment = FactoryBot.create(:user_comment, user_id: user2.id, author_id: user.id)
      visit user_url(user2)
      expect(page).to have_content(user_comment.body)
      click_button("Delete Comment")
      expect(page).to_not have_content(user_comment.body)
    end
  end
end
