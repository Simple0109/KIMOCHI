Rails.application.routes.draw do
  root 'top_page#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resource :profile, only: %i[show edit update]

  resources :groups do
    post 'generate_token', to: 'invites#generate_token'
    get 'process_invite_link/:invite_token', to: 'invites#process_invite_link', as: 'invite_link'
    delete 'secession', to: 'groups#secession'
    resources :requests do
      post 'admit', to: 'approvals#admit'
      post 'cancel_admit', to: 'approvals#cancel_admit'
      post 'task_completed', to: 'approvals#task_completed'
      resources :gives, only: [] do
        member do
          post 'update_status_completed', to: 'gives#update_status_completed'
          post 'update_status_uncompleted', to: 'gives#update_status_uncompleted'
        end
      end
    end
  end
end
