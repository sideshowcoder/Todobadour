Todobadour::Application.routes.draw do
  # Lists resource
  resources :lists, :only => [:create, :show, :destroy, :update, :email] do
    member do
      post :email
    end
    resources :todos, :only => [:create, :destroy, :update]
  end
  
  # Make list respond to default url
  match "/:id", :to => "lists#show"
    
  # Pages Controller
  get "pages/home"
  get "pages/about"

  # Static Pages
  match "/about", :to => 'pages#about'
  root :to => 'pages#home'  
  
end
