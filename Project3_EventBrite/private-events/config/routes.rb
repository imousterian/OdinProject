Rails.application.routes.draw do

    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :show, :destroy]
    resources :events

    get 'events/:id/register', to: 'events#register', as: :register

    get 'events/:id/accept_request', to: 'events#accept_request', as: :accept_request

    root 'events#index'

    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get' # mapping signin route to acton 'new'
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/about', to: "static_pages#about", via: 'get'
end
