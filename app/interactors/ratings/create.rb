module Ratings
  class Create
    include Interactor::Organizer

    organize CreateRating, CalculatePostAverageRating, CalculateUserRating
  end
end
