require 'rails_helper'
RSpec.feature "Task management function", type: :feature do
  background do
    User.create!(names: "lompo", email: 'lompo@gmail.Com', user_type: 'admin',  password: 'lompo123')
    visit  log_in_path
    fill_in  'Email' ,  with: 'lompo@gmail.Com'
    fill_in  'Password' ,  with: 'lompo123'
    click_on  'Log in'
    click_on 'New Task'
      fill_in  'username' ,  with: 'task1'
      fill_in  'Content' ,  with: 'content1'
      click_on 'Submit'
  end
  scenario "Test task list" do

    visit tasks_path
    save_and_open_page
    expect(page).to have_content 'task1'
    expect(page).to have_content 'content1'
  end

  scenario "Test task creation" do
    visit new_task_path



    fill_in  'userName' ,  with: 'completed'
    fill_in  'Content' ,  with: 'lets do it'

    click_on  'Submit'

    expect(page ).to  have_content  'lets do it'
  end

  scenario "Test task details" do
    @task = Task.first
    visit task_path(id: @task.id)
    expect(page).to have_content('task1')
    expect(page).to have_content('content1')
  end

  scenario "Test whether tasks are arranged in descending order of creation date" do
    task = Task.order('created_at DESC')

  end
  scenario "Test task updating" do
    @task = Task.first
    visit edit_task_path(id: @task.id)
    fill_in 'Name', with: 'name update'
    fill_in 'Content', with: 'content update'
    click_on 'Submit'
    visit tasks_path
    expect(page).to have_content('name update')
    expect(page).to have_content('content update')
  end
  scenario 'Test Task Deletion' do
    @task = Task.first
    @task.destroy
    visit tasks_path
    expect(page).not_to have_content('content1')
  end
  scenario 'Test Task validation' do
    visit tasks_path
    click_on 'New Task'
      fill_in  'username' ,  with: 'task1'
      click_on 'Submit'
      expect(page).to have_content(`Name can't be blank`)

  end
  scenario "Test whether tasks are arranged in descending order of deadline" do
    click_on 'New Task'
      fill_in  'Name' ,  with: 'task2'
      fill_in  'Content' ,  with: 'content2'
      click_on 'Submit'
      @task = Task.first
      @task_newest = Task.last
      @task_newest.end_date = '10.12.2020'
      @task_newest.save
      task  = Task.order('end_date desc').all
    expect(task).to eq([@task_newest, @task])
  end
  scenario "Test whether tasks are arranged in descending order of priority" do
    click_on 'New Task'
      fill_in  'Name' ,  with: 'task2'
      fill_in  'Content' ,  with: 'content2'
      click_on 'Submit'
      @task = Task.first
      @task_newest = Task.last
      @task_newest.end_date = '10.12.2020'
      @task_newest.save
      task  = Task.order('end_date desc').all
    expect(task).to eq([@task_newest, @task])
  end
  scenario "test task search" do
    visit tasks_path
    fill_in  'term' ,  with: 'task1'
    click_on ' Search'
    expect(page).to have_content('content1')
  end
