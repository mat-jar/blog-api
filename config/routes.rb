Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/users', defaults: { format: :json },
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  post 'api/v1/users/user_details/show', to: 'users/user_details#show'
  put 'api/v1/users/user_details', to: 'users/user_details#update'
  get 'api/v1/users/user_details/show_all', to: 'users/user_details#show_all'

  scope '/api/v1' do
    resources :articles
  end

  namespace :api do
      namespace :v1 do
        resources :learning_sessions do
          post 'show_specific', on: :collection
          post 'show_accessible', on: :collection
          # on: :collection  zamienia /api/v1/learning_sessions/:id/show_specific(.:format)  na /api/v1/learning_sessions/show_specific(.:format)
        end
        resources :flashcard_sets do
          post 'show_accessible', on: :collection
          post 'show_shared', on: :collection
          get 'shared_flashcards', to: 'flashcards#shared_flashcards'
        end
        resources :user_sentence_sets do
          post 'show_accessible', on: :collection
          post 'show_shared', on: :collection
          get 'shared_user_sentences', to: 'user_sentences#shared_user_sentences'
        end
      end
    end

    namespace :api do
        namespace :v1 do
          post 'answer_times', to: 'answer_times#create'
          namespace :answer_times do
            post 'user_average', to: 'user_average'
            post 'flashcard_set_average', to: 'flashcard_set_average'
            post 'word_average', to: 'word_average'
            post 'learning_session_average', to: 'learning_session_average'
          end
        end
      end

    namespace :api do
        namespace :v1 do
          post 'teacher_tokens', to: 'teacher_tokens#create'
        end
      end

        namespace :api do
            namespace :v1 do
              post 'english_sentences', to: 'english_sentences#show'
              post 'english_sentences/translate', to: 'english_sentences#translate'
              post 'english_sentences/random', to: 'english_sentences#random'
            end
          end

  namespace :api do
      namespace :v1 do
        resources :flashcard_sets do
          resources :flashcards, shallow: true
        end
      end
  end

  namespace :api do
      namespace :v1 do
        resources :user_sentence_sets do
          resources :user_sentences, shallow: true
        end
      end
  end

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

end
