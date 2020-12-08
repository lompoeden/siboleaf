FactoryBot.define do

    factory :task do
        start_date { '1/1/2020' }
        end_date { '1/2/2020' }
        status { 'pending' }
        priority { '2' }
    end

    factory :second_task, class: Task do
        start_date { '1/1/2020' }
        end_date { '1/3/2020' }
        status { 'done' }
        priority { '1' }
    end

end
