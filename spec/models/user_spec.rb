require 'rails_helper'
RSpec.describe 'User management function', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe 'New creation function test' do
    context 'When you write a new test for the user' do
      it 'User details are displayed' do
        visit tasks_path
        click_on 'Sign up'
        fill_in 'username', with: 'test3'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'Create an account'
        expect(page).to have_content 'test3'
        expect(page).to have_content 'test@test.com'
      end
    end
    context 'If you try to jump to the task list without logging in' do
      it 'Transition to the login screen' do
        visit tasks_path
        expect(page).to have_content 'Please login'
      end
    end
  end

  describe 'General user session function test' do
    context 'If you have user data and are not logged in' do
      it 'Being able to log in' do
        visit new_session_path
        fill_in 'session_email', with: 'lompo@gmail.com'
        fill_in 'session_password', with: 'password'
        sleep 0.5
        click_on 'Log in'
        expect(page).to have_content 'Task list'
      end
    end
    context 'If the user is logged in' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'lompo@gmail.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
      end
      it 'See your details page' do
        click_on 'Profile'
        expect(page).to have_content 'lompo@gmail.com'
      end
      it 'Jumping to another person's detail page will return you to the task list screen' do
        visit user_path(admin_user.id)
        expect(page).to have_content 'Not authorized'
      end
      it 'Cannot access the management screen' do
        visit admin_users_path
        expect(page).to have_content 'Only the administrator can access！'
      end
      it 'being able to logout' do
        click_on 'Logout'
        expect(page).to have_content 'user logged out'
      end
    end
  end

  describe 'Administrative User Session Functional Test' do
    context 'context'if the admin user is logged in' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'kana@kana.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
      end
      it 'being able to access management screen' do
        visit admin_users_path
        expect(page).to have_content 'user management list'
      end
      it 'Being able to to create new users' do
        click_on 'create account'
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'Create account'
        expect(page).to have_content 'test_user'
      end
      it 'Access to the user details screen' do
        visit admin_user_path(user.id)
        expect(page).to have_content 'user1page'
      end
      it 'scenaria delete' do
        visit edit_admin_user_path(user.id)
        fill_in 'user_name', with: 'update_user'
        fill_in 'user_email', with: 'eden@lom.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'Edit account'
        expect(page).to have_content 'update'
      end
      it 'Being able to delete users' do
        visit admin_users_path
        within first('tbody tr') do
         click_link 'Delete'
        end
        expect(page).to have_content 'user deleted'
      end
    end
  end

end
