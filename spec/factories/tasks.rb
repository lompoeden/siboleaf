FactoryBot.define do
  factory :task do
    title { 'Task Name' }
    content { 'Task Details' }
  end
  factory :second_task, class: Task do
    title { 'title test 2' }
    description { 'content' }

  end
end
