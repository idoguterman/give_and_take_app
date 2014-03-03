FactoryGirl.define do

  factory :image do |img|

     trait :sample1 do
       avatar "https://fbcdn-photos-g-a.akamaihd.net/hphotos-ak-ash3/t1/1377472_10152855384258539_1641771815_s.jpg"
		 end

		 trait :sample2 do
       avatar "https://fbcdn-photos-h-a.akamaihd.net/hphotos-ak-prn1/t1/47009_432009338538_6624028_s.jpg"
		 end
     
		 factory :image_sample1, traits:[:sample1]
		 factory :image_sample2, traits:[:sample2]
  end


  factory :user do |f|

  f.first_name Faker::Name.first_name 
	f.last_name Faker::Name.last_name
  f.password "foobarbar"
  f.password_confirmation { |u| u.password }
	f.gender true
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  #f.age rand(10..90)
  #f.association :images, factory:[:image_sample1]
	after(:create) do |user, evaluator|
   create(:image_sample1, user: user)
   create(:image_sample2, user: user)
  end

  #f.images.create(:image_sample1)
	#, create(:image_sample2)]
end
end
