require "spec_helper"

describe DrugsController do
  describe "routing" do

    it "routes to #index" do
      get("/packages/1/drugs").should route_to("drugs#index", package_id: "1")
    end

    it "does not route to #new" do
      get("/packages/1/drugs/new").should_not route_to("drugs#new", package_id: "1")
    end

    it "does not route to #edit" do
      get("/packages/1/drugs/1/edit").should_not route_to("drugs#edit", package_id: "1")
    end

    it "routes to #show" do
      get("/packages/1/drugs/1").should route_to("drugs#show", id: "1", package_id: "1")
    end

    it "routes to #create" do
      post("/packages/1/drugs").should route_to("drugs#create", package_id: "1")
    end

    it "routes to #update" do
      put("/packages/1/drugs/1").should route_to("drugs#update", id: "1", package_id: "1")
    end

    it "routes to #destroy" do
      delete("/packages/1/drugs/1").should route_to("drugs#destroy", id: "1", package_id: "1")
    end

  end
end
