Todobadour::Application.routes.draw do
  # Lists resource
  resources :lists do
    # Nested Todos with complete CRUD
    resources :todos
  end
    
  # Pages Controller
  get "pages/home"
  get "pages/about"

  # Static Pages
  match "/about", :to => 'pages#about'
  root :to => 'pages#home'  
  
end
