object false

node :links do
  {
    :"apprenticeships.master" => {
      href: root_url + "api/users/{apprenticeships.master}",
      type: "users"
    },
    :"apprenticeships.apprentice" => {
      href: root_url + "api/users/{apprenticeships.apprentice}",
      type: "users"
    },
    :"apprenticeships.ratings" => {
      href: root_url + "api/ratings/{apprenticeships.ratings}",
      type: "ratings"
    }
  }
end

child @apprenticeships do
  extends "apprenticeships/show"
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

    ratings: Rating.all.map do |rating|
      {
        href:   rating_url(rating),
        id:     rating.id,
        rater:  rating.rater.id,
        ratee:  rating.ratee.id,
        rating: rating.rating
      }
    end
  }
end