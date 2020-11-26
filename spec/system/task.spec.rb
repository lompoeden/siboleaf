require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do

  scenario "Test task list" do

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "in progress", from: "task[status]"
   select "high", from: "task[priority]"
   click_on 'search'

   visit new_task_path
   fill_in "task[title]", with: "title3"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "low", from: "task[priority]"
   click_on 'search'

   visit tasks_path


   expect(page).to have_content('title3')
   expect(page).to have_content('low')
   expect(page).to have_content('high')
   expect(page).to have_content('in progress')
   expect(page).to have_content('Not yet started')

 end

 scenario "Test task creation" do

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "high", from: "task[priority]"
   click_on 'search'
   expect(page).to have_content 'Task was successfully created'

 end

 scenario "Test of task details" do

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "high", from: "task[priority]"
   click_on 'search'
   visit tasks_path
   click_on 'Show'
   expect(page).to have_content "Not yet started"

 end

 scenario "Test whether tasks are arranged in descending order of creation date" do

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "high", from: "task[priority]"
   click_on 'search'

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "low", from: "task[priority]"
   click_on 'search'

   visit tasks_path
   tasks = page.all('tr')
   expect(tasks[1]).to have_content('high')
   expect(tasks[2]).to have_content('low')
 end


 scenario "Test search by status" do
   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "low", from: "task[priority]"
   click_on 'search'

   visit tasks_path
   fill_in "q[status_cont]", with: "Not yet started"
   click_on 'search'
   expect(page).to have_content "Not yet started"
 end


 scenario "Test search by title" do
   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "low", from: "task[priority]"
   click_on 'search'

   visit tasks_path
   fill_in "q[title_cont]", with: "test2"
   click_on 'search'
   expect(page).to have_content "test2"
 end

 scenario "Test sort by priority" do

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "high", from: "task[priority]"
   click_on 'search'

   visit new_task_path
   fill_in "task[title]", with: "test2"
   fill_in "task[start_date]", with: Date.new(1/1/2020)
   fill_in "task[end_date]", with: Date.new(1/2/2020)
   select "Not yet started", from: "task[status]"
   select "low", from: "task[priority]"
   click_on 'search'

   visit tasks_path
   click_on 'sort by priority'
   tasks = page.all('tr')
   expect(tasks[1]).to have_content('low')
   expect(tasks[2]).to have_content('high')

 end

end
