Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users

  resources :groups
end
