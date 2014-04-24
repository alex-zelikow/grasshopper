require 'spec_helper'

describe User do

  before :each do
    @user = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
  end

  describe "password is provided" do

    it "should be valid with password_confirmation" do
      @user.save
      expect(@user).to be_valid
    end

    context "password_confirmation is provided as empty" do
      it "should be invalid without password_confirmation" do
        @user.password_confirmation = ''
        @user.save
        expect(@user).to have(1).errors_on(:password_confirmation)
      end
    end

    context "password_confirmation is provided as nil" do
      it "should be valid without password_confirmation" do
        @user.password_confirmation = nil
        @user.save
        expect(@user).to be_valid
      end
    end
  end

  describe "authenticate username and password" do
    describe "self.authenticate" do
      context "correct password" do
        it "should be valid to authenticate" do
          expect(User.authenticate('gh@ga.co', '123')).to eq(@user)
        end
      end

      context "incorrect password" do
        it "should return nil to authenticate" do
          expect(User.authenticate('gh@ga.co', '122')).to eq(nil)
        end
      end
    end

    describe "authenticate" do
      it "should authenticate correctly" do
        auth_result = @user.authenticate '123'
        result = @user.fish == BCrypt::Engine.hash_secret('123', @user.salt)
        expect(auth_result).to eq result
      end
    end
  end

  describe "reset password" do
    before :each do
      @params = { password: "1234", password_confirmation: "1234" }
    end
    context "password is blank" do
      it "should be invalid if password is blank" do
        @user.password = nil
        expect(@user).to_not be_valid
      end
    end

    context "password is not blank" do
      context "password with confirmation matches" do
        it "should have the fish and salt changed" do
          fish = @user.fish
          salt = @user.salt
          @user.reset_password(@params)
          expect(@user.fish).to_not eq fish
          expect(@user.salt).to_not eq salt
        end
      end
    end

    it "should have code and expires_at to not be nil" do
      @user.reset_password(@params)
      expect(@user.reset_code).to be_nil
      expect(@user.reset_expires_at).to be_nil
    end

    context "password with confirmation not matches" do
      it "should have the fish and salt unchanged" do
        @params[:password_confirmation] = 'abcd'
        old_fish = @user.fish
        @user.reset_password @params
        expect(old_fish).to eq @user.fish
      end
    end
  end

  describe "Set random password if password is not provided" do
    before :each do
      @user = User.new email: 'harry@ga.co', first_name: "", last_name: ""
    end

    context "salt and fish exists" do
      it "should have value in salt and fish" do
        @user.send(:set_random_password)
        expect(@user.salt).to_not be_nil
        expect(@user.fish).to_not be_nil
      end
    end
  end

  describe "Password is encrypted before save" do
    before :each do
      @new_user = User.new first_name: 'Grass', last_name: 'Hopper', email: 'gn@ga.co', password: '123', password_confirmation: '123', role: 'master'
    end

    context "password is present" do
      it "should have value in salt and fish" do
        @user.password = '1234'
        @user.send(:encrypt_password)
        expect(@user.salt).to_not be_nil
        expect(@user.fish).to_not be_nil
      end

      context "encrypted password is not the same as plain" do
        it "should have values of password and fish differently" do
          @user.password = '1234'
          @user.send(:encrypt_password)
          expect(@user.password).to_not eq @user.fish
        end
      end
    end
  end

  it "should be valid with a first name, last name, email, role, and status" do
    expect(@user).to be_valid
  end

  it "should not be valid without a first name" do
    @user.first_name = nil
    expect(@user).to_not be_valid
  end
  it "should not be valid without a last name" do
    @user.last_name = nil
    expect(@user).to_not be_valid
  end
  it "should not be valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end
  it "should not be valid without a role" do
    @user.role = nil
    expect(@user).to_not be_valid
  end
  it "should not be valid without is_active" do
    @user.is_active = nil
    expect(@user).to_not be_valid
  end

  describe "first_name" do
    it "should be ASCII letters with one whitespace separating multiple names" do
      @user.first_name = 'L33t'
      expect(@user).to_not be_valid
      @user.first_name = ''
      expect(@user).to_not be_valid
      @user.first_name = 'White McSpace'
      expect(@user).to be_valid
    end
    it "should fix whitespace" do
      @user.first_name = 'Bad  Whitespace'
      expect(@user).to be_valid
    end
  end

  describe "last_name" do
    it "should be ASCII letters with one whitespace separating multiple names" do
      @user.last_name = 'L33t'
      expect(@user).to_not be_valid
      @user.last_name = ''
      expect(@user).to_not be_valid
      @user.last_name = 'White McSpace'
      expect(@user).to be_valid
    end
    it "should fix whitespace" do
      @user.last_name = 'Bad  Whitespace'
      expect(@user).to be_valid
    end
  end

  describe "email" do
    it "should be a valid email format" do
      @user.email = 'gh.ga@co'
      expect(@user).to_not be_valid
    end
  end

  describe "role" do
    it "should be either 'master' or 'apprentice'" do
      @user.role = 'masters'
      expect(@user).to_not be_valid
    end
  end

  describe "is_active" do
    it "should be true when user is saved" do
      expect(@user.is_active).to eq true
    end
  end

  describe "generate username" do
   it "should generate a username when user is created" do
    expect(@user.username).to eq 'grasshopper'
   end
  end

  describe "Delete user" do
    it "should delete the current user" do
      expect(User.find_by_username("grasshopper")).to_not be_nil
      @user.destroy
      expect(User.find_by_username("grasshopper")).to be_nil
    end
  end
end