Rails.application.routes.draw do
  resources :kids do
    member do
      post :set_co_parent
      post :set_observer
      post :login_as
      post :bump_level
    end
  end
  resources :cards
  resources :kid_grownups
  resources :grownups
  resources :activities
  resources :accounts
  resources :kids
  resources :customers
  resources :kid_grownups
  resources :grownups
  resources :activities
  resources :accounts
  resources :parents
  resources :kids
  resources :kid_parents
  resources :admins
  resources :activities
  resources :accounts do
    resources :activities
  end

  root 'welcome#index'

  resources :sessions
  resources :phones

  namespace "kbi" do
    root 'dashboard#welcome'
  end

  namespace "api" do
    root 'api#welcome'
    namespace "v1" do
      get 'accounts', :to => "api#accounts"
      get 'kids', :to => "api#kids"
    end
  end

  get 'react', :to => "kids#react"

end
