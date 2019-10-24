FactoryBot.define do 
    factory :mission do 
        user
        name {Faker::Lorem.word}
        start_at {Faker::Time.backward(days: 1)}
        end_at {Faker::Time.forward(days: 1)}
    end
end