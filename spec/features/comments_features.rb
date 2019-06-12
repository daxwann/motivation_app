require 'rails_helper'

feature 'comments' do
  subject(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_user(user.username, user.password)
  end

  feature 'commenting on goals page' do
    let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

    scenario 'includes comments' do
      goal_comment = FactoryBot.create(:goal_comment, goal_id: goal.id, author_id: user.id)
      visit goal_url(goal)
      expect(page).to have_content("Comments")
      expect(page).to have_content(goal_comment.body)
    end

    scenario 'includes comment form' do
      visit goal_url(goal)
      expect(page).to have_content("New Comment")
    end

    scenario 'add comment' do
    end

    scenario 'delete comment' do
    end
  end
  
  feature 'commenting on users' do
    let(:user2) { FactoryBot.create(:user) }

    scenario '
  end
end
