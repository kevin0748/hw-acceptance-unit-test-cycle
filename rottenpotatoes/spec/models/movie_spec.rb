require 'rails_helper'

# https://github.com/rails/rails/issues/34790#issuecomment-450502805
if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe Movie, type: :model do
  
  it "should return the correct matches for movies by the same director" do
    Movie.create(id: 1, title: "Inception", director: "Nolan")
    Movie.create(id: 2, title: "Dunkrik", director: "Nolan")
    Movie.create(id: 3, title: "Django", director: "Quentin")
    
    expect(Movie.with_director("Nolan").length).to eq(2)
    expect(Movie.with_director("Quentin").length).to eq(1)
  end
  
  it "should not return matches of movies by different directors" do
    expect(Movie.with_director("Wei").length).to eq(0)
  end
end
