Asagao::Application.routes.draw do
  root to: "top#index"
  get "about" => "top#about", as: "about"

  get "lesson/:action(/:name)" => "lesson"

  resources :members, only: [:index, :show] do
    collection { get "search" }
    
    resources :entries
  end
  resources :entries do
    member { put "like", "unlike" }
    collection { get "voted" }
  end

  resources :articles, only: [:index, :show]

  resource :session, only: [:create, :destroy]

  namespace :admin do
    root to: "top#index"
    resources :members do
      collection { get "search" }
    end
    resources :articles
  end

  resource :account, only: [:show, :edit, :update]

  match "*anything" => "top#not_found"
end
