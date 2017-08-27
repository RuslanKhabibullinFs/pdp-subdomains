module Ratings
  class Create
    include Interactor::Organizer

    organize CreateRating, CalculatePostAverageRating
  end
end
