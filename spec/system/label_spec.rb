require 'rails_helper'
RSpec.feature "Label Management Function", type: :feature do
  background do
    FactoryBot.create(:user)
    visit new_session_path
    fill_in 'Email', with: 'lompo@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    @user = User.first
    FactoryBot.create(:label, name: "label1", user_id: @user.id)
    FactoryBot.create(:label, name: "label2", user_id: @user.id)
    FactoryBot.create(:label, name: "label3", user_id: @user.id)
    FactoryBot.create(:task, title: 'Testing',
                             content: 'testing the content',
                             priority:'low',
                             user_id: @user.id)
  end
  scenario "Test Label list" do
    visit labels_path
    click_on "Show", match: :first
    find('body').has_content? 'label1'
  end

  scenario "Test Label Creation" do
    visit new_label_path
    fill_in 'Name', with: 'label4'
    click_button 'Save'
    find('body').has_content? 'label4'
  end

  scenario "Search & Test Label attached to task" do
    @task = Task.first
    @label1 = Label.first
    @label2 = Label.second
    @task.labels = [@label1, @label2]
    @task.save
    visit tasks_path
    fill_in 'search_label', with: 'label1'
    find('body').has_content? 'label1'
  end
end
