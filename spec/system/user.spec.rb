# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)


RSpec.feature "user management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  background do
    User.create!(names: "lompo", email: 'lompo@gmail.com', user_type: 'admin',  password: 'lompo123')
    visit  log_in_path
    #click_on 'Login'
    fill_in  'Email' ,  with: 'lompo@gmail.com'
    fill_in  'Password' ,  with: 'lompo123'
    click_on  'Log in'

  end

  scenario "Test number of users" do

    User.create!(names: '', email: 'lompo@gmail.com', user_type: 'admin', password: 'lompo123')
    @user = User.all.count
    expect(@user).to eq 2
  end

  scenario "Test user list" do

    User.create!(names: 'lompo', email: 'lompo@iuj.ac.jp', user_type: 'admin', password: 'lompo123')
    visit admin_users_path
    expect(page ).to  have_content  'Miyembal'
    expect(page ).to  have_content  'lompo'
  end

  scenario "Test user creation" do
    User.create!(names: 'lompo', email: 'lompo@gmail.com', user_type: 'admin', password: 'lompo123')
    visit admin_users_path
    expect(page ).to  have_content  'lompo'
  end

  scenario "test enable user creation page" do
    visit admin_users_path

    expect(page ).to  have_content  'lompo'
  end

  scenario "Test user details" do
    @user= User.create!(names: 'lompo', email: 'lompo@gmail.com', user_type: 'admin', password: 'lompo123')


    visit admin_user_path(id: @user.id)
    expect(page).to have_content('lompo@gmail.com')
    expect(page).to have_content('admin')
  end
  scenario "Test user updating" do
    @user = User.first
    visit edit_admin_user_path(id: @user.id)
    fill_in 'username', with: 'username update'
    fill_in 'Email', with: 'lompo@gmail.com'
    click_on 'Update User'
    visit admin_users_path
    expect(page).to have_content('lompo@gmail.com')
    expect(page).to have_content('name update')
  end
  scenario 'Test user Deletion' do
    User.create!(names: 'lompomiyemba', email: 'lompomiyemba1@gmail.com', user_type: 'admin', password: 'lompo123')
    @user = User.last
    @user.destroy

    #click_on 'Destroy'
    visit users_path
    expect(page).not_to have_content('lompomiyemba')
  end
end
