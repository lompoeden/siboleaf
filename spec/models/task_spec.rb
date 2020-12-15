require 'rails_helper'
RSpec.describe Task, type: :model do

  it "Validation does not pass if the start date is empty" do
    task = Task.new(startdate: '', enddate: '1/2/2020', status: 'in progress', priority: 'low')
    expect(task).not_to be_valid
  end

  it "Validation does not pass if the end date is empty" do
    task = Task.new(startdate: '1/2/2020', enddate: '', status: 'in progress', priority: '2')
    expect(task).not_to be_valid
  end

  it "Validation does not pass if the priority is empty" do
    task = Task.new(startdate: '1/2/2020', enddate: '1/4/2020', status: 'in progress', priority: '')
    expect(task).not_to be_valid
  end

  it "validation passes If content is described in title and content" do
    task = Task.new(startdate: '1/1/2020', enddate: '1/2/2020', status: 'in progress', priority: '1')
    expect(task).to be_valid
  end

  it  "Search with title: title24, find 1 result" do
    Task.create(startdate: '1/1/2020', enddate: '1/2/2020', status: 'completed', title: 'title24', priority: '1')
    expect(Task.search_title('title24').count).to eq 1
  end

  it  "Search with status: completed, find 1 result" do
    Task.create(startdate: '1/1/2020', enddate: '1/2/2020', status: 'completed', title: 'title24', priority: '1')
    expect(Task.search_status('completed').count).to eq 1
  end

end
