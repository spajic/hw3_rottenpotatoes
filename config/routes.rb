Rottenpotatoes::Application.routes.draw do
  post '/movies/search_movies_with_given_director', :as=>:search_movies_with_given_director
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
