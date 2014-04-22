collection @proficiency, root: "proficiencies", :object_root => false

attributes :id, :proficiency_status

node :links do |proficiency|
  {
    skill:
      {
        href: skill_url(proficiency.skill),
        id: proficiency.skill.id,
        name: proficiency.skill.skill_name,
        type: "skill"
      },
    user:
      {
        href: user_url(proficiency.user),
        id: proficiency.user.id,
        type: "user"
      }
  }
end