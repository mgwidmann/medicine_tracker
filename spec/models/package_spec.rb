require 'spec_helper'

describe Package do

  let(:package) { create(:package) }
  let(:package_without_drugs) { create(:package_without_drugs) }

  it "creates a factory with all data" do
    package.drugs.should be_present
    package.drugs.each {|d| d.expiration_dates.should be_present }
  end

  describe "#expiration_date" do

    context "with data" do

      let(:unexpired_package) { create(:unexpired_package) }
      let(:expired_package) { create(:expired_package) }
      let(:mixed_package) { create(:package) }

      it "returns the minimum date" do
        unexpired_package.expiration_date.should == 10.days.from_now.to_date
        expired_package.expiration_date.should == 10.days.ago.to_date
        mixed_package.expiration_date.should == 10.days.ago.to_date
      end

    end

    context "no data" do

      let(:package) { create(:package_no_dates) }

      it "returns nil when there are no expiration dates" do
        package.expiration_date.should be_nil
      end
    end

  end

end
