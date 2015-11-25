Rottenpotatoes::Application.routes.draw do
  resources :movies
  match '/movies/:id/director', to: 'movies#show_director', :as => :director, via: :get
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
