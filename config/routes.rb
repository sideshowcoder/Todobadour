Todobadour::Application.routes.draw do
  # Lists resource
  resources :lists, :only => [:create, :show, :destroy, :update, :email] do
    member do
      post :email
    end
    resources :todos, :only => [:create, :destroy, :update]
  end
    
  # Static Pages
  root to: "high_voltage/pages#show", id: "home"

end
