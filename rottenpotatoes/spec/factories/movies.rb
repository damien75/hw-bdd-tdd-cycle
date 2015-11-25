FactoryGirl.define do
  factory :movie do
    title 'A Fake Title1'
    rating 'R'
    director 'Director'
    release_date {5.years.ago}
  end
end