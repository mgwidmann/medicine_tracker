require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #create" do
      post("/users/sign_in").should route_to("sessions#create")
    end

    # Implemented by Devise via inheritance
    it "routes to #destroy" do
      delete("/users/sign_out").should route_to("sessions#destroy")
    end

  end
end
