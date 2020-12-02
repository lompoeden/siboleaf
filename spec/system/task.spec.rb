require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do

  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
        visit new_task_path
        fill_in "Title", with: 'title test'
        fill_in "Content", with: 'content test'
        select 'started'
        select 'low'
        click_on 'Save'
        expect(page).to have_content 'title test'
      end
    end
  end

  describe 'detailed display function' do
    context 'to transition to any task detail screen' do
      it 'contents of relevant task should be displayed' do
        visit new_task_path
        fill_in "Title", with: 'title test'
        fill_in "Content", with: 'content test'
        select 'started'
        select 'low'
        click_on 'Save'
        expect(page).to have_content 'content test'
      end
    end
  end

  describe 'created at test' do
    context 'When you click the  Sort by creation button in the task list' do
      it 'list tasks sorted in descending order of creation date' do
        visit tasks_path
        click_on "Sort by creation"
        assert Task.all.order('created_at desc')
      end
    end
  end

  describe 'created at test' do
    context 'When you click the Sort by  button in the task list' do
      it 'list tasks sorted in descending order of deadline' do
        visit tasks_path
        click_on "Sort by enddate"
        assert Task.all.order('enddate desc')
      end
    end
  end

  describe 'search function' do
    context 'If you do a fuzzy search for the title with the scope method' do
      it "Narrows down tasks that include search keywords with title" do
        visit new_task_path
        fill_in "Title", with: 'title'
        fill_in "Content", with: 'content test'
        select 'started'
        select 'low'
        click_on 'Save'
        expect(page).to have_content 'content test'
        visit tasks_path
        fill_in "Title search", with: "title"
        click_on "search"
        expect(page).to have_content 'title'
      end
    end

    context 'When a status search is performed with the scope method' do
      it "Narrows down tasks that exactly match with status" do
        visit new_task_path
        fill_in "Title", with: 'title'
        fill_in "Content", with: 'content test'
        select 'started'
        select 'low'
        click_on 'Save'
        expect(page).to have_content 'content test'
        visit tasks_path
          fill_in "Status search", with: 'Not yet started'
        click_on "search"
        expect(page).to have_content 'Not yet started'
      end
    end

    context 'If  you  do a fuzzy search and status search for the title with the scope method' do
      it "Narrow down tasks that include search keywords in the title and exactly match the status" do
        visit new_task_path
        fill_in "Title", with: 'title'
        fill_in "Content", with: 'content test'
        select 'started'
        select 'low'
        click_on 'Save'
        expect(page).to have_content 'content test'
        visit tasks_path
        fill_in "Title search", with: "title"
        fill_in "Status search", with: 'Not yet started'
        click_on "search"
        expect(page).to have_content 'Not yet started'
        expect(page).to have_content 'title'
      end
    end
  end

end
