Rails.application.routes.draw do
  root 'top_page#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resource :profile, only: %i[show edit update]

  resources :groups do
    get 'new', to: 'invites#new', as: 'invite_new'
    post 'generate_token', to: 'invites#generate_token'
    get 'process_invite_link/:invite_token', to: 'invites#process_invite_link', as: 'invite_link'
    resources :requests do
      post 'apply', to: 'approvals#apply'
      post 'cancel_apply', to: 'approvals#cancel_apply'
      post 'admit', to: 'approvals#admit'
      post 'cancel_admit', to: 'approvals#cancel_admit'
    end
  end
end
