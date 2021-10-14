class Movie < ActiveRecord::Base
    def self.with_director(director)
        return Movie.where("director = ?", director)
    end
    
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
end
