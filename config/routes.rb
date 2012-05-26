Todobadour::Application.routes.draw do
  # Lists resource
  resources :lists, :only => [:create, :show, :destroy, :update, :email] do
    member do
      post :email
    end
    # Nested Todos with complete CRUD
    resources :todos, :only => [:create, :show, :destroy, :update]
  end
    
  # Pages Controller
  get "pages/home"
  get "pages/about"

  # Static Pages
  match "/about", :to => 'pages#about'
  root :to => 'pages#home'  
  
end
