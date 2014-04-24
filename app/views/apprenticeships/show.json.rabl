collection @apprenticeship, root: "apprenticeships", :object_root => false

attributes :id, :end_date, :created_at, :updated_at

node :links do |apprenticeship|
  {
    master:
      {
        href: user_url(apprenticeship.master),
        id: apprenticeship.master.id,
        type: "users"
      },

    apprentice:
      {
        href: user_url(apprenticeship.apprentice),
        id: apprenticeship.apprentice.id,
        type: "users"
      },

    ratings:
      apprenticeship.ratings.map do |rating|
        {
          href: rating_url(rating),
          id: rating.id,
          type: "ratings"
        }
      end
  }
end

