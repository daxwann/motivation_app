require 'rails_helper'

feature 'goals CRUD' do
  subject(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_user(user.username, user.password)
  end

  feature 'showing list of goals' do
    scenario 'has an index page' do
      visit goals_url
      expect(page).to have_content "All Goals"
    end

    scenario 'includes all goals by user' do
      let(:goal1) { FactoryBot.create(:goal, user_id: user.id) }
      let(:goal2) { FactoryBot.create(:goal, user_id: user.id) }
      visit goals_url
      expect(page).to have_content goal1.title
      expect(page).to have_content goal2.title
    end
  end

  feature 'creating a goal' do
    scenario 'has a new goal form page' do
      visit new_goal_url
      expect(page).to have_content "New Goal"
    end

    scenario 'invalidates wrong params' do
      visit new_goal_url
      fill_in "Title", with: ""
      fill_in "Detail", with: ""
      choose('goal[public]', option: 'false')
      click_button('Create')
      expect(current_path).to eq("/goals")
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Detail can't be blank"
    end

    scenario 'creates goal with correct params' do
      visit new_goal_url
      fill_in "Title", with: "finish appacademy"
      fill_in "Detail", with: "learn ruby, sql, rails, javascript"
      choose('goal[public]', option: 'false')
      click_button('Create')
      expect(current_path).to eq(/goals\/[0-9]+/)
      expect(page).to have_content "finish appacademy"
      expect(page).to have_content "learn ruby, sql, rails, javascript"
      expect(page).to have_content "Not Completed"
    end
  end

  feature 'updating a goal' do
    before(:each) do
      @goal1 = FactoryBot.create(:goal, user_id: user.id)
    end

    scenario 'has an edit goal form page' do
      visit edit_goal_url(@goal1.id)
      expect(page).to have_content "Edit Goal"
    end

    scenario 'invalidates wrong params' do
      visit edit_goal_url(@goal1.id)
      fill_in "Title", with: ""
      fill_in "Detail", with: ""
      click_button('Change')
      expect(current_path).to eq("/goals/#{ @goal1.id }")
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Detail can't be blank"
    end

    scenario 'updates goal with correct params' do
      visit edit_goal_url(@goal1.id)
      fill_in "Title", with: "finish appacademy"
      fill_in "Detail", with: "learn ruby, sql, rails, javascript"
      choose('goal[public]', option: 'true')
      choose('goal[completed]', option: 'true')
      click_button('Change')
      expect(current_path).to eq("/goals/#{ @goal1.id }")
      expect(page).to have_content "finish appacademy"
      expect(page).to have_content "learn ruby, sql, rails, javascript"
      expect(page).to have_content "Completed"
    end
  end

  feature 'deleting a goal' do
    before(:each) do
      @goal1 = FactoryBot.create(:goal, user_id: user.id)
    end

    scenario 'has a show goal page' do
      visit goal_url(@goal1)
      expect(page).to have_content @goal1.title
      expect(page).to have_content @goal1.detail
      expect(page).to have_content "Not Completed"
    end

    scenario 'deletes goal' do
    end

    scenario 'doesn\'t show goal in list' do
    end
  end
end
