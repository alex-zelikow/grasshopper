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

  get 'privacy' => 'site#privacy'
  get 'terms'   => 'site#terms'
  get 'profile-template' => 'site#index_template'

  #delete user
  delete 'user' => 'user#destroy'

  #User Profile
  get 'profile' => 'users#show'

  scope :api do

    root to: 'api#index', defaults: { format: :json }, as: :api_root

    resources :users, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "users#show", on: :collection
    end

    resources :skills, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "skills#show", on: :collection
    end

    resources :proficiencies, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "proficiencies#show", on: :collection
    end

    resources :conversations, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "conversations#show", on: :collection
    end

    resources :messages, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "messages#show", on: :collection
    end

    resources :apprenticeships, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "apprenticeships#show", on: :collection
    end

    resources :ratings, except: [ :edit, :new ], defaults: { format: :json } do
      get ':id' => "ratings#show", on: :collection
    end

  end

end
