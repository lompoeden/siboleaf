require 'rails_helper'
RSpec.describe 'User registration/login/logout function', type: :system do

  describe 'User registration test' do
    context 'If the user is not logged in' do
      it 'should register new user' do
        visit new_user_path
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Create my account'
        expect(page).to have_content 'test'
      end

      it 'should jump to login screen when not logged in' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe "Session login test" do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end
    context "If the user is logged in" do

      it 'navigating to other user profile will return you to the tasks list screen' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit user_path(id: @admin_user.id)
        expect(current_path).to eq tasks_path
      end

      it 'should not be able to access the management screen' do
        visit new_user_path
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Create my account'
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end

      it 'should be able to log out' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "Management screen test" do
    context "If there are no admin users" do
      it "be able to access management page" do
        user = User.create(username: "Lompo", email: "lompo@gmail.com", password: "lompo123", password_confirmation: "lompo123", admin: true)
        visit new_session_path
        fill_in "session_email", with: "lompo@gmail.com"
        fill_in "session_password", with: "lompo123"
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content "List of Users"
      end

      it 'should create new user' do
        user = User.create(username: "Lompo2", email: "lompo2@gmail.com", password: "lompo1232", password_confirmation: "lompo1232", admin: true)
        visit new_session_path
        fill_in "session_email", with: "lompo2@gmail.com"
        fill_in "session_password", with: "lompo1232"
        click_button 'Log in'
        visit admin_users_path
        click_link 'Create user'
        expect(page).to have_content "New User"
      end

      it 'should be able to access user profile' do
        user = User.create(username: "Lompo", email: "lompo@gmail.com", password: "lompo123", password_confirmation: "lompo123", admin: true)
        visit new_session_path
        fill_in "session_email", with: "lompo@gmail.com"
        fill_in "session_password", with: "lompo123"
        click_button 'Log in'
        visit admin_user_path(user)
        expect(page).to have_content 'lompo@gmail.com'
      end

      it 'should be able to access user edit screen' do
        user = User.create(username: "Lompo", email: "lompo@gmail.com", password: "lompo123", password_confirmation: "lompo123", admin: true)
        visit new_session_path
        fill_in "session_email", with: "lompo@gmail.com"
        fill_in "session_password", with: "lompo123"
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content 'Edit'
      end

      it 'Being able to delete users' do
        user = User.create(username: "Lompo", email: "lompo@gmail.com", password: "lompo123", password_confirmation: "lompo123", admin: true)
        visit new_session_path
        fill_in "session_email", with: "lompo@gmail.com"
        fill_in "session_password", with: "lompo123"
        click_button 'Log in'
        visit admin_users_path
        click_on 'Delete'
        expect(page).not_to have_content 'admin@example.com'
      end
    end
  end
end
