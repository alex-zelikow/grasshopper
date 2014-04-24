object false

node :links do
  {
    :"skills.proficiencies" => {
      href: root_url + "apprenticeships/{skills.proficiencies}",
      type: "proficiencies"
    }
  }
end

child @skills do
  extends "skills/show"
end

node :linked do
  {
    proficiencies:
      @proficiencies.map do |proficiency|
        {
          href: proficiency_url(proficiency),
          id: proficiency.id,
          skill: proficiency.skill.id,
          proficiency_status: proficiency.proficiency_status
        }
      end
  }
end