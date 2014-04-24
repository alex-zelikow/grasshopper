require 'spec_helper'

describe RatingsController, :type => :api do

  render_views

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: (1.second.from_now))
    @rating = Rating.create(rater: @user1, ratee: @user2, apprenticeship: @apprenticeship, rating: 5)
  end


  describe 'GET index' do

    it "returns list of ratings" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["ratings"][0]["rating"]).to eq 5
      expect(JSON.load(response.body)["ratings"][0]["links"]["rater"]["id"]).to eq @user1.id
      expect(JSON.load(response.body)["ratings"][0]["links"]["ratee"]["id"]).to eq @user2.id
      expect(JSON.load(response.body)["ratings"][0]["links"]["apprenticeship"]["id"]).to eq @apprenticeship.id
    end

  end

end