Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :profile, only:[:show, :edit, :update]

  resources :groups do
    resources :requests
  end

  resources :invites, only: [:new, :create]

end
