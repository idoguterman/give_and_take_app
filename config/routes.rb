GiveAndTakeApp::Application.routes.draw do

  get "welcome/index"
  resources :locations
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get '/auth/:provider/callback' => 'authentications#create'
  get '/auth/failure' => redirect('/')

  get "/products/index.js" => 'users#index', :format => :js
  devise_for :users , :controllers => {:registrations => 'registrations'} #, path_names: {sign_in: "login", sign_out: "logout"}
  resources :users do
    resources :images
  end
  resources :authentications
  resources :activities
 
  root :controller => 'welcome', :action => :index 
  end
