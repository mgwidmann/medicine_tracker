require 'spec_helper'

describe Drug do

  let(:drug) { build(:drug) }
  let(:valid_drug) { create(:package).drugs.first }

  it "requires a package" do
    drug.should_not be_valid
    drug.errors[:package].should be_present
  end

  it "stores many expiration dates" do
    valid_drug.expiration_dates.size.should == 2
  end

  describe "#expiration_date" do
    let(:package) { create(:package) }

    context "with data" do

      let(:unexpired_drug) { create(:unexpired_drug, package: package) }
      let(:expired_drug) { create(:expired_drug, package: package) }
      let(:mixed_drug) { create(:drug, package: package) }

      it "returns the minimum date" do
        unexpired_drug.expiration_date.should == 10.days.from_now.to_date
        expired_drug.expiration_date.should == 10.days.ago.to_date
        mixed_drug.expiration_date.should == 10.days.ago.to_date
      end

    end

    context "no data" do

      let(:drug) { create(:drug_no_dates, package: package) }

      it "returns nil when there are no expiration dates" do
        drug.expiration_date.should be_nil
      end
    end

  end

end
