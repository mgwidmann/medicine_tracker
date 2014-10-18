require 'spec_helper'

describe ExpirationDate do
  let(:package) { build(:package) }
  let(:drug) { build(:drug, package: package) }
  let(:date) { create(:expiration_date, drug: drug) }

  it "requires having a drug" do
    date.drug.should be
  end

end
