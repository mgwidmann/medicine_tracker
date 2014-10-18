require "spec_helper"

describe ExpirationDatesController do
  describe "routing" do

    it "routes to #index" do
      get("/packages/1/drugs/1/expiration_dates").should route_to("expiration_dates#index",
        package_id: "1", drug_id: "1")
    end

    it "does not route to #new" do
      get("/packages/1/drugs/1/expiration_dates/new").should_not route_to("expiration_dates#new",
        package_id: "1", drug_id: "1")
    end

    it "routes to #show" do
      get("/packages/1/drugs/1/expiration_dates/1").should route_to("expiration_dates#show", id: "1",
        package_id: "1", drug_id: "1")
    end

    it "does not route to #edit" do
      get("/packages/1/drugs/1/expiration_dates/1/edit").should_not route_to("expiration_dates#edit", :id => "1",
        package_id: "1", drug_id: "1")
    end

    it "routes to #create" do
      post("/packages/1/drugs/1/expiration_dates").should route_to("expiration_dates#create",
        package_id: "1", drug_id: "1")
    end

    it "routes to #update" do
      put("/packages/1/drugs/1/expiration_dates/1").should route_to("expiration_dates#update", id: "1",
        package_id: "1", drug_id: "1")
    end

    it "routes to #destroy" do
      delete("/packages/1/drugs/1/expiration_dates/1").should route_to("expiration_dates#destroy", id: "1",
        package_id: "1", drug_id: "1")
    end

  end
end
