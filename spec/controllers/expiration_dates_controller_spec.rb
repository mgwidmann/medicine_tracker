require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ExpirationDatesController do

  before(:each) { sign_in :user, create(:user) }

  let(:package) { create(:empty_package) }
  let(:drug) { create(:drug_no_dates, package: package) }
  let(:expiration_date) { create(:future_date, drug: drug) }

  # This should return the minimal set of attributes required to create a valid
  # ExpirationDate. As you add validations to ExpirationDate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "date" => "2014-10-16" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ExpirationDatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) { expiration_date.should be }

  describe "GET index" do
    it "assigns all expiration_dates as @expiration_dates" do
      get :index, {package_id: package.id, drug_id: drug.id, format: :json}, valid_session
      assigns(:expiration_dates).should eq([expiration_date])
    end
  end

  describe "GET show" do
    it "assigns the requested expiration_date as @expiration_date" do
      get :show, {id: expiration_date.to_param, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
      assigns(:expiration_date).should eq(expiration_date)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ExpirationDate" do
        expect {
          post :create, {expiration_date: valid_attributes, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
        }.to change(ExpirationDate, :count).by(1)
      end

      it "assigns a newly created expiration_date as @expiration_date" do
        post :create, {expiration_date: valid_attributes, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
        assigns(:expiration_date).should be_a(ExpirationDate)
        assigns(:expiration_date).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expiration_date as @expiration_date" do
        # Trigger the behavior that occurs when invalid params are submitted
        ExpirationDate.any_instance.stub(:save).and_return(false)
        post :create, {expiration_date: { "date" => "invalid value" }, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
        assigns(:expiration_date).should be_a_new(ExpirationDate)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested expiration_date" do
        # Assuming there are no other expiration_dates in the database, this
        # specifies that the ExpirationDate created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ExpirationDate.any_instance.should_receive(:update).with({ "date" => "2014-10-16", "drug_id" => "1" })
        put :update, {id: expiration_date.to_param, expiration_date: { "date" => "2014-10-16" }, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
      end

      it "assigns the requested expiration_date as @expiration_date" do
        put :update, {id: expiration_date.to_param, :expiration_date => valid_attributes, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
        assigns(:expiration_date).should eq(expiration_date)
      end
    end

    describe "with invalid params" do
      it "assigns the expiration_date as @expiration_date" do
        # Trigger the behavior that occurs when invalid params are submitted
        ExpirationDate.any_instance.stub(:save).and_return(false)
        put :update, {id: expiration_date.to_param, expiration_date: { "date" => "invalid value" }, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
        assigns(:expiration_date).should eq(expiration_date)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested expiration_date" do
      expect {
        delete :destroy, {id: expiration_date.to_param, package_id: package.id, drug_id: drug.id, format: :json}, valid_session
      }.to change(ExpirationDate, :count).by(-1)
    end
  end

end
