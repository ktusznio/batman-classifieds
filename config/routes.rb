Classifieds::Application.routes.draw do
  resources :ads do

    member do
      put 'close'
    end

    collection do
      get 'search'
      get 'user_ads'
      get '/:filter', :to => 'ads#index', :as => :filter, :constraints => { :filter => /free|trade|closed/ }
    end
  end

  resources :messages, :only => [:create]
  resources :locales, :only => [:show], :constraints => {:id => /en|fr|pr/}

  match '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
  match '/sessions/current', :to => 'sessions#current'

  root :to => "application#app"
end
