Rails.application.routes.draw do
  resources :tasks
  devise_for :users
  post ':tasks/:id/:toggle', to: 'tasks#toggle'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
