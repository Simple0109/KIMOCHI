Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users do
    resource :profile
  end

  resources :groups do
    resources :requests
  end

end
