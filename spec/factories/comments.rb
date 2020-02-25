FactoryBot.define do  
  factory :comment do
    body {Faker::Lorem.sentence}
    image{File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
    group
  end
end