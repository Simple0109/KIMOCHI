Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users

  resource :profile

  resources :groups do
    resources :requests
  end

end
