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
  get 'posts/random(/:id)'  => 'posts#random'  
  get 'posts/user'          => 'posts#user_post'  
  post 'posts/:post_id/likes' => 'likes#create'

  resources :posts , except: [:new, :edit] 
  
  # Generates automatically
  # ---------------------------------------------------------- 
  # posts GET    /posts(.:format)               posts#index
  #       POST   /posts(.:format)               posts#create
  #  post GET    /posts/:id(.:format)           posts#show
  #       PATCH  /posts/:id(.:format)           posts#update
  #       PUT    /posts/:id(.:format)           posts#update
  #       DELETE /posts/:id(.:format)           posts#destroy

  # Add:
  # http://localhost:3000/users/12/likes
  # http://localhost:3000/posts/20/likes
end
