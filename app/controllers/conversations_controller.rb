class ConversationsController < ApplicationController
  respond_to :json

  before_action :get_conversation, only: [ :update, :destroy ]


  def index
    @conversations = if params[:id]
      Conversation.where('id in (?)', params[:id].split(','))
    else
      Conversation.all
    end

    @users = (@conversations.map { |conversation| [conversation.created_by, conversation.created_for] }).flatten.sort.uniq
    @messages = (@conversations.map { |conversation| conversation.messages }).flatten.sort.uniq
  end

  def create
    binding.pry
    params[:conversation][:created_by] = User.find(params[:created_by])
    params[:conversation][:created_for] = User.find(params[:created_for])
    binding.pry

    conversation = Conversation.new conversation_params
    binding.pry

    if conversation.save
      head :created, location: conversation_url(conversation)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @conversation.update(conversation_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @conversation.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def conversation_params
    binding.pry
    params.require(:conversation).permit(:created_by, :created_for).pry
  end

  def get_conversation
    head :not_found unless @conversation = Conversation.where('id = ?', params[:id]).take
  end

end