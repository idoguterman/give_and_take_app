GiveAndTakeApp::Application.routes.draw do

  resources :locations
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get '/auth/:provider/callback' => 'authentications#create'

  devise_for :users , :controllers => {:registrations => 'registrations'} #, path_names: {sign_in: "login", sign_out: "logout"}

  resources :authentications
  resources :activities
 
  root :to => "activities#index"
  end
