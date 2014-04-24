object false

node :links do
  {
    :"conversations.created_by" => {
      href: root_url + "api/users/{conversations.created_by}",
      type: "users"
    },
    :"conversations.created_for" => {
      href: root_url + "api/users/{conversations.created_for}",
      type: "users"
    },
    :"conversations.messages" => {
      href: root_url + "api/messages/{conversations.messages}",
      type: "messages"
    }
  }
end

child @conversations do
  extends "conversations/show"
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

    messages: @messages.map do |message|
      {
        href:   message_url(message),
        id:     message.id,
        sender: message.sender.id,
        recipient: message.recipient.id,
        message: message.content
      }
    end
  }
end