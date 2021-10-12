class Movie < ActiveRecord::Base
    def self.same_director(director)
        return Movie.where("director = ?", director)
    end
end
