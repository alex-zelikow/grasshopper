require 'spec_helper'

describe ApprenticeshipsController, :type => :api do

  render_views

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: 1.day.from_now)
    @rating1 = Rating.create(rater: @user1, ratee: @user2, apprenticeship: @apprenticeship, rating: 5)
    @rating2 = Rating.create(rater: @user2, ratee: @user1, apprenticeship: @apprenticeship, rating: 3)
  end

  describe 'GET index' do

    it "returns list of apprenticeships" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["apprenticeships"][0]["end_date"]).to eq @apprenticeship.end_date.iso8601(3)
      expect(JSON.load(response.body)["apprenticeships"][0]["links"]["master"]['id']).to eq @user1.id
      expect(JSON.load(response.body)["apprenticeships"][0]["links"]["apprentice"]['id']).to eq @user2.id
      expect(JSON.load(response.body)["apprenticeships"][0]["links"]["ratings"][0]['id']).to eq @rating1.id
    end

  end
end