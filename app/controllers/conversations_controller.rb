class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.all
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  def update
    binding.pry
    create_message(params) if current_user == params[:sender]
  end

end