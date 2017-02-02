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
  resources :accounts
  root 'welcome#index'

end
