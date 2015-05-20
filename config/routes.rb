Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'authenticated' => 'users/sessions#authenticated'
  end

  # get '/', to: 'controller_names#action_name'
  # root 'controller_names#action_name'
  root 'static_pages#index'
  resources :posts
  
end
