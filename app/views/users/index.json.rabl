object false

node :links do
  {
    :"users.apprenticeships" => {
      href: root_url + "apprenticeships/{users.apprenticeships}",
      type: "apprenticeships"
    },
    :"users.proficiencies" => {
      href: root_url + "proficiencies/{users.proficiencies}",
      type: "proficiencies"
    },
    :"users.conversations" => {
      href: root_url + "conversations/{users.conversations}",
      type: "conversations"
    }
  }
end

child @users do
  extends "users/show"
end

node :linked do
  {
    apprenticeships:
      @apprenticeships.map do |apprenticeship|
        {
          href: apprenticeship_url(apprenticeship),
          id: apprenticeship.id,
          master: apprenticeship.master.id,
          apprentice: apprenticeship.apprentice.id,
          created_at: apprenticeship.created_at,
          end_date: apprenticeship.end_date
        }
      end,
    proficiencies:
      @proficiencies.map do |proficiency|
        {
          href: proficiency_url(proficiency),
          id: proficiency.id,
          skill: proficiency.skill.id,
          proficiency_status: proficiency.proficiency_status,
        }
      end,
    conversations:
      @conversations.map do |conversation|
        {
          href: conversation_url(conversation),
          id: conversation.id,
          created_by: conversation.created_by.id,
          created_for: conversation.created_for.id
        }
      end
  }
end





