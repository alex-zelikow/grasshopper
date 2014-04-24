object false

node :links do
  {
    :"proficiencies.user" => {
      href: users_url + "/{proficiencies.user}",
      type: "user"
    },
    :"proficiencies.skill" => {
      href: skills_url + "/{proficiencies.skill}",
      type: "skill"
    }
  }
end

child @proficiencies do
  extends "proficiencies/show"
end

node :linked do
  {
    users:
      @users.map do |user|
        {
          href: user_url(user),
          id: user.id,
          username: user.username,
        }
      end,
    skills:
      @skills.map do |skill|
        {
          href: skill_url(skill),
          id: skill.id,
          skill_name: skill.skill_name,
        }
      end
  }
end





