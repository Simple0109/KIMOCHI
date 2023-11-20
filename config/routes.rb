Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users
  resource :profile, only:[:show, :edit, :update]

  resources :groups do
    resources :requests
  end

end
