Rails.application.routes.draw do
  resources :kids
  resources :kid_grownups
  resources :grownups
  resources :activities
  resources :accounts
  resources :kids
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

  namespace "api" do
    root 'api#welcome'
    namespace "v1" do
      get 'accounts', :to => "api#accounts"
      get 'kids', :to => "api#kids"
    end
  end


end
