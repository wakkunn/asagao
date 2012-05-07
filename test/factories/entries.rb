FactoryGirl.define do
  factory :entry do
    author { Factory(:member) }
    sequence(:title) { |n| "Entry#{n}" }
    body "Blah, Blah, Blah."
    posted_at Time.current
    status "public"
  end
end
