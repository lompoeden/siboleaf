FactoryBot.define do
  factory :task do
    title { 'task13' }
    content { 'content jetaime' }
    enddate { '2020-12-02 11:00:00' }
  end
  factory :second_task, class: Task do
    title { 'task12' }
    content { 'content jysuis' }
    enddate{ '2020-12-02 00:00:00' }
  end
  factory :third_task, class: Task do
    title { 'test2' }
    content { 'task' }
    enddate{ '2020-11-26 17:00:00' }
  end
end
