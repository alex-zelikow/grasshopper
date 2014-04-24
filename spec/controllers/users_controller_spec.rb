require 'spec_helper'

describe UsersController, :type => :api do

  render_views

  before :each do
    User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
  end

  describe 'GET index' do

    it "returns list of users" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["users"][0]["email"]).to eq 'gh@ga.co'
      expect(JSON.load(response.body)["users"][0]["first_name"]).to eq 'Grass'
      expect(JSON.load(response.body)["users"][0]["last_name"]).to eq 'Hopper'
      expect(JSON.load(response.body)["users"][0]["role"]).to eq 'master'
    end

  end

  describe "GET profile" do
    context "when not logged in" do
      it "should return unauthorised response" do
        session[:user_id] = nil
        get :profile, :format => :json
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      it "should return profile" do
        session[:user_id] = User.first.id
        get :profile, :format => :json
        expect(response.status).to eq 200
      end
    end
  end

end