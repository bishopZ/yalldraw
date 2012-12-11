Yalldraw::Application.routes.draw do
  root to: 'drawings#index'

  resources :users, except: [:destroy, :update, :edit] do
    collection do
      post 'login'
      get 'logout'
    end
  end

  resources :drawings, except: [:edit, :index] do
    post 'add'
    post 'remove'
  end
end
