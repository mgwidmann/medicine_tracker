FactoryGirl.define do
  factory :drug do
    after(:create) do |drug|
      create(:expired_date, drug: drug)
      create(:future_date, drug: drug)
    end
  end
  factory :unexpired_drug, class: Drug do
    after(:create) do |drug|
      create(:future_date, drug: drug)
    end
  end
  factory :expired_drug, class: Drug do
    after(:create) do |drug|
      create(:expired_date, drug: drug)
    end
  end
  factory :drug_no_dates, class: Drug do

  end
end
