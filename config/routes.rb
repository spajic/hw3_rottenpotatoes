Rottenpotatoes::Application.routes.draw do
  resources :movies
  post '/movies/search_movies_with_given_director'
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
