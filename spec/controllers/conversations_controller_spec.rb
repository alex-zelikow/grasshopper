require 'spec_helper'

describe ConversationsController, :type => :api do

  render_views

  before(:each) do
    @grasshopper = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @master = User.create(first_name: 'Master', last_name: 'Hopper', email: 'gm@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @conversation = Conversation.create(created_by: @grasshopper, created_for: @master)
    @message = @conversation.messages.create(sender: @grasshopper, recipient: @master, content: "How are you?")
  end

  describe 'GET index' do

    it "returns list of conversations" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["conversations"][0]["id"]).to eq @conversation.id
      expect(JSON.load(response.body)["conversations"][0]["links"]["created_by"]["id"]).to eq @grasshopper.id
      expect(JSON.load(response.body)["conversations"][0]["links"]["created_for"]["id"]).to eq @master.id
      expect(JSON.load(response.body)["conversations"][0]["links"]["messages"][0]["id"]).to eq @message.id
    end

  end

end