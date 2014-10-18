FactoryGirl.define do
  factory :expiration_date do
    factory :expired_date do
      date { 10.days.ago }
    end
    factory :future_date do
      date { 10.days.from_now }
    end
    association :drug, factory: :drug
  end
end
