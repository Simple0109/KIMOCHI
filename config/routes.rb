Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'top_page#top'
  get 'terms', to: 'top_page#terms'
  get 'privacy', to: 'top_page#privacy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    sessions: 'users/sessions'
  }
  resource :profile, only: %i[show edit update]

  resources :personal_requests, only: %i[index]

  resources :groups do
    post 'generate_token', to: 'invites#generate_token'
    get 'process_invite_link/:invite_token', to: 'invites#process_invite_link', as: 'invite_link'
    delete 'secession', to: 'groups#secession'
    resources :requests do
      get 'completed_requests', on: :collection, to: 'requests#completed_requests', as: 'completed'
      post 'admit', to: 'approvals#admit'
      post 'cancel_admit', to: 'approvals#cancel_admit'
      post 'task_completed', to: 'approvals#task_completed'
      get 'search'
      resources :gives, only: [] do
        member do
          post 'update_status_completed', to: 'gives#update_status_completed'
          post 'update_status_uncompleted', to: 'gives#update_status_uncompleted'
        end
      end
    end
  end
end
