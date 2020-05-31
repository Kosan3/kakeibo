Rails.application.routes.draw do
  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }
  root 'books#index_all'
  resources :books
  get '/books_all' => 'books#index_all'
  get '/ago_books' => 'books#index_ago'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
