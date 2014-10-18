require 'spec_helper'

describe User do

  describe "fields" do

    let(:user) { User.new }

    it "accepts a password" do
      user.password = "password"
      user.password.should == "password"
    end

    it "accepts a password_confirmation" do
      user.password_confirmation = "password"
      user.password_confirmation.should == "password"
    end

    it "accepts an email" do
      user.email = "user@example.com"
      user.email.should == "user@example.com"
    end

    it "has a password_hash field" do
      user.password_hash = BCrypt::Engine.hash_secret("password", "$2a$10$NnwS7rlPprq.odwwfiIq1.")
      user.password_hash.should == "$2a$10$NnwS7rlPprq.odwwfiIq1.BSD11I6BuyNorRi6uLJhleRpKdQ3IZe"
    end

    it "has a password_salt field" do
      user.password_salt = "don't make this random for testing purposes"
      user.password_salt.should == "don't make this random for testing purposes"
    end
  end

  describe "validations" do

    let(:user) { User.new }

    context "password confirmation" do
      before :each do
        user.email = "user@example.com"
      end
      it "requires password when password_confirmation exists" do
        user.password_confirmation = "password"
        user.save.should be_false
      end
      it "requires password_confirmation when password exists" do
        user.password = "password"
        user.save.should be_false
      end
      it "password and password_confirmation must be the same" do
        user.password = "password"
        user.password_confirmation = "wrong"
        user.save.should be_false
      end
    end

    context "email uniqueness" do
      before :each do
        @user = create(:user)
        user.email = @user.email
        user.password_confirmation = user.password = "password"
      end
      it "cannot create another user with the same email" do
        user.should_not be_valid
      end
    end

    describe "hash and salt" do

      let(:user) { create(:user) }

      describe "creation" do
        it "sets password_hash" do
          user.password_hash.should be
        end
        it "sets password_salt" do
          user.password_salt.should be
        end
      end

      it "does not allow removing the password_hash" do
        user.password_hash = nil
        user.save.should be_false
      end

      it "does not allow removing the password_salt" do
        user.password_salt = nil
        user.save.should be_false
      end

    end
  end

  describe "login" do

    before(:each) { @user = create(:user) }

    context "correct credentials" do
      it "returns the user" do
        User.login("test@test.com", "testtest").should eq(@user)
      end
    end

    context "incorrect credentials" do
      it "for the correct email, wrong password returns nil" do
        User.login("test@test.com", "testwrong").should_not be
      end
      it "for the correct password, wrong email returns nil" do
        User.login("user@test.com", "testtest").should_not be
      end
    end

  end

end
