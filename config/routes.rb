Grasshopper::Application.routes.draw do
  root 'site#index'

  # Log in/out
  get    'login'  => 'session#new',     as: :login_form
  post   'login'  => 'session#create',  as: :log_in
  delete 'logout' => 'session#destroy', as: :log_out

  # Registration
  get  'register'       => 'session#register',    as: :register_view
  get  'register/:code' => 'registration#new',    as: :registration_form
  post 'register/:code' => 'registration#create', as: :register

  # Password reset
  get   'reset_password' => 'session#reset_password', as: :password_reset_start
  get   'reset/:code'    => 'password#edit',          as: :password_reset_form
  patch 'reset/:code'    => 'password#update',        as: :reset_password

  #Conversations
  patch 'create/:conversation/:content/from/:sender/' => 'conversations#update', as: :add_message

  get 'privacy' => 'site#privacy'
  get 'terms'   => 'site#terms'
  get 'profile-template' => 'site#index_template'

  #delete user
  # delete 'user' => 'user#destroy'

  #User Profile

  scope :api do

    root to: 'api#index', defaults: { format: :json }, as: :api_root

    get 'user' => 'users#profile', defaults: { format: :json }, as: :profile

    resources :users, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "users#index", on: :collection

      resources :proficiencies, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "proficiencies#index", on: :collection

        resources :skills, except: [ :show, :edit, :new ], defaults: { format: :json } do
          get ':id' => "skills#index", on: :collection
        end
      end

      resources :conversations, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "conversations#index", on: :collection

        resources :messages, except: [ :show, :edit, :new ], defaults: { format: :json } do
          get ':id' => "messages#index", on: :collection
        end

      end

      resources :apprenticeships, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "apprenticeships#index", on: :collection

        resources :ratings, except: [ :show, :edit, :new ], defaults: { format: :json } do
          get ':id' => "ratings#index", on: :collection
        end
      end
    end

    resources :proficiencies, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "proficiencies#index", on: :collection

      resources :skills, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "skills#index", on: :collection
      end
    end

    resources :skills, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "skills#index", on: :collection
    end

    resources :conversations, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "conversations#index", on: :collection

      resources :messages, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "messages#index", on: :collection
      end
    end

    resources :messages, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "messages#index", on: :collection
    end

    resources :apprenticeships, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "apprenticeships#index", on: :collection

      resources :ratings, except: [ :show, :edit, :new ], defaults: { format: :json } do
        get ':id' => "ratings#index", on: :collection
      end
    end

    resources :ratings, except: [ :show, :edit, :new ], defaults: { format: :json } do
      get ':id' => "ratings#index", on: :collection
    end

  end

end
