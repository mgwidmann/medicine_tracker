FactoryGirl.define do
  factory :package do
    name "New Drug"
    serial "12345"
    after(:create) do |package|
      create(:drug, package: package)
    end
  end
  factory :empty_package, class: Package do
  end
  factory :unexpired_package, class: Package do
    after(:create) do |package|
      create(:unexpired_drug, package: package)
    end
  end
  factory :expired_package, class: Package do
    after(:create) do |package|
      create(:expired_drug, package: package)
    end
  end
  factory :package_no_dates, class: Package do
    after(:create) do |package|
      create(:drug_no_dates, package: package)
    end
  end
end
