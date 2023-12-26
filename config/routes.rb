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
      post 'admit', to: 'approvals#admit'
      post 'cancel_admit', to: 'approvals#cancel_admit'
      resources :gives, only: [] do
        member do
          post 'update_status_completed', to: 'gives#update_status_completed'
          post 'update_status_uncompleted', to: 'gives#update_status_uncompleted'
        end
      end
    end
  end
end
