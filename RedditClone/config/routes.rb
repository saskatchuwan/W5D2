Rails.application.routes.draw do
  resources :users, only:[:create, :new]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
end
