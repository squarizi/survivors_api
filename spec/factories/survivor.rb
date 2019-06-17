FactoryBot.define do
  factory :survivor do
    name Faker::Name.name
    birth_date Faker::Date.birthday(18, 65)
    gender 1
    contaminated false
    last_location({})

    trait :female do
      gender 1
    end

    trait :male do
      gender 2
    end

    trait :contaminated do
      contaminated true
    end

    trait :with_last_location do
      last_location({ lat: -52.211139, lng: -68.328125 })
    end
  end
end
