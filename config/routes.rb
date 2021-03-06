Rails.application.routes.draw do
  resources :about
  resources :kids do
    member do
      post :set_co_parent
      post :set_observer
      post :login_as
    end
  end
  resources :cards
  resources :deals
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
  resources :atms

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
      get 'coparents', :to => "api#coparents"

      resources :atms do
        member do
          post :deposit
        end
      end
      resources :customers do
        member do
          get :atms
        end
        collection do
          post :login
        end
      end
    end
  end

  get 'react', :to => "kids#react"

end
