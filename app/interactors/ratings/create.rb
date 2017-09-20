module Ratings
  class Create
    include Interactor::Organizer

    organize CreateRating, CalculateAverageRating
  end
end
