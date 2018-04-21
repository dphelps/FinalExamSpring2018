FactoryBot.define do

  factory :user do
    first_name "Daniel"
    last_name "Phelps"
    username "dphelps"
    phone "4122920324"
    email "dphelps@cmu.edu"
    password "foobar"
    password_confirmation "foobar"
    active true
  end

  factory :booking do
    start_date 1.week.from_now.to_date
    end_date 2.weeks.from_now.to_date
    association :room
    association :user
  end
  
  factory :room do
    room_number 100
    room_type "Suite"
    booked false 
  end
end