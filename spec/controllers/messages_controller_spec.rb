require 'spec_helper'

describe MessagesController, :type => :api do

  render_views

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @conversation = Conversation.create(created_by: @user1, created_for: @user2)
    @message1 = Message.create(recipient: @user1, sender: @user2, conversation: @conversation, content: 'Content1')
    @message2 = Message.create(recipient: @user2, sender: @user1, conversation: @conversation, content: 'Content2')
  end

  describe 'GET index' do

    it "returns list of messages" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["messages"][0]["content"]).to eq 'Content1'
      expect(JSON.load(response.body)["messages"][0]["links"]["recipient"]["id"]).to eq @user1.id
      expect(JSON.load(response.body)["messages"][0]["links"]["sender"]["id"]).to eq @user2.id
      expect(JSON.load(response.body)["messages"][0]["links"]["conversation"]["id"]).to eq @conversation.id
    end

  end

end