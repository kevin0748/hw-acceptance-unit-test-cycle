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

RSpec.describe MoviesController do
    describe "When the specified movie has a director" do
        it "should render same_director template" do
            fake_movie = double('Movie', id: '19', title:'fake_title_19', director: 'fake_director_19')
            Movie.should_receive(:find).with('19').and_return(fake_movie)
    
            get :same_director, {:id => '19'}
            expect(response.status).to render_template("movies/same_director")
        end
    end
        
    describe "When the specified movie has no director" do
        it "should redirect to /movies" do
            fake_movie = double('Movie', id: '19', title:'', director:'')
            Movie.should_receive(:find).with('19').and_return(fake_movie)
            
            get :same_director, {:id => '19'}
            expect(response).to redirect_to(movies_path)
        end
    end
end
