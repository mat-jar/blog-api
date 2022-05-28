Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/users', defaults: { format: :json },
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get 'api/v1/users/user_details', to: 'user_details#show'
  scope '/api/v1' do
    resources :articles
  end

  namespace :api do
      namespace :v1 do
        resources :learning_sessions do
          post 'show_specific', on: :collection
          # on: :collection  zamienia /api/v1/learning_sessions/:id/show_specific(.:format)  na /api/v1/learning_sessions/show_specific(.:format)
        end
      end
    end


  namespace :api do
      namespace :v1 do
        resources :flashcard_sets do
          resources :flashcards, shallow: true
        end
      end
  end

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
