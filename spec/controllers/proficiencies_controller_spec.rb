require 'spec_helper'

describe ProficienciesController, :type => :api do

  render_views

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @skill1 = Skill.create(skill_name: 'electrician')
    @skill2 = Skill.create(skill_name: 'jedi')
    @proficiency1 = Proficiency.create(proficiency_status: 'has', user: @user1, skill: @skill1)
    @proficiency2 = Proficiency.create(proficiency_status: 'desired', user: @user2, skill: @skill2)
  end

  describe 'GET index' do

    context 'from /proficiencies' do
      it "returns all proficiencies" do
        get :index, :format => :json
        expect(response.status).to eq 200
        expect(JSON.load(response.body)["proficiencies"].length).to eq 2
      end
    end

    context 'from /users/1/proficiencies' do
      it "returns user1's proficiencies" do
        get :index, user_id: @user1.id, :format => :json
        expect(response.status).to eq 200
        expect(JSON.load(response.body)["proficiencies"][0]['id']).to eq @proficiency1.id
      end
    end

  end

end