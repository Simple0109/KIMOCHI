Rails.application.routes.draw do
  root "top_page#top"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :profile, only:[:show, :edit, :update]

  resources :groups do
    resources :requests do
      post "apply", to: "approvals#apply"
      post "cancel_apply", to: "approvals#cancel_apply"
      post "admit", to: "approvals#admit"
      post "cancel_admit", to: "approvals#cancel_admit"
    end
  end

  resources :invites, only: [:new, :create]

end
