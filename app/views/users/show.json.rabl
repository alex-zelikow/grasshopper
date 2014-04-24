collection @user, root: "users", :object_root => false

attributes :id, :email, :first_name, :last_name, :username, :role, :is_active, :about_me

node :links do |user|
  {
    apprenticeships:
      Apprenticeship.involve_user(user).map do |apprenticeship|
        {
          href: apprenticeship_url(apprenticeship),
          id: apprenticeship.id,
          type: "apprenticeships"
        }
      end,

    proficiencies:
      user.proficiencies.map do |proficiency|
        {
          href: proficiency_url(proficiency),
          id: proficiency.id,
          status: proficiency.proficiency_status,
          skill: proficiency.skill.skill_name,
          type: "proficiencies"
        }
      end,
    conversations:
      Conversation.involve_user(user).map do |conversation|
        {
          href: conversation_url(conversation),
          id: conversation.id,
          type: "conversations"
        }
      end
  }
end
