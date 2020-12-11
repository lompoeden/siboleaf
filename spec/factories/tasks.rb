FactoryBot.define do

    factory :task do
        title { 'haha' }
        content { 'yep' }
        startdate { '1/1/2020' }
        enddate { '1/2/2020' }
        status { 'pending' }
        priority { '2' }
    end

    factory :second_task, class: Task do
        title { 'well' }
        content { 'we will see' }
        status { 'done' }
        priority { '1' }
    end

end
