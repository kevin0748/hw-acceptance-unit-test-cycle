Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get 'movies/:id/same-director', to: 'movies#same_director', as: :same_director
end
