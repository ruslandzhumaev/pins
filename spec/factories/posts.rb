FactoryGirl.define do
  factory :post do |f|
    f.title "Test title"
    f.text "Test text"
    f.category_id 1
  end
end