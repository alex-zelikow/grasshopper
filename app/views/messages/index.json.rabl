object false

node :links do
  {
    :"messages.conversation" => {
      href: root_url + "users/{messages.conversation}",
      type: "conversations"
    },
    :"messages.sender" => {
      href: root_url + "users/{messages.sender}",
      type: "users"
    },
    :"messages.recipient" => {
      href: root_url + "users/{messages.recipient}",
      type: "users"
    }
  }
end

child @messages do
  extends "messages/show"
end

node :linked do
  {
    users: @users.map do |user|
      {
        href:     user_url(user),
        id:       user.id,
        username: user.username
      }
    end,

    conversations: @conversations.map do |conversation|
      {
        href:   conversation_url(conversation),
        id:     conversation.id,
        created_by: conversation.created_by.id,
        created_for: conversation.created_for.id,
        created_at: conversation.created_at,
        updated_at: conversation.updated_at
      }
    end
  }
end