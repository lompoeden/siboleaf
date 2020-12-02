FactoryBot.define do
  factory :task do
    title { 'task13' }
    content { 'content jetaime' }
  end
  factory :second_task, class: Task do
    title { 'task12' }
    content { 'content jysuis' }
  end
  factory :third_task, class: Task do
    title { 'test2' }
    content { 'task' }
  end
end
