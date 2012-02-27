Todobadour::Application.routes.draw do
  # Lists Controller
  resources :lists, :only => [:show, :create, :destroy]
    
  # Pages Controller
  get "pages/home"
  get "pages/about"

  # Static Pages
  match "/about", :to => 'pages#about'
  root :to => 'pages#home'  
  
end
