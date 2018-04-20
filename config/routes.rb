Rails.application.routes.draw do
  
  
  get 'thai_musics/index'

  devise_for :allusers
  
  resources :todo_lists
  #get 'admin/index'

  #get 'form1/index'

  #get 'form1/index'
  get 'schools/index'
  get 'pages/show'
  
  get 'pages/index'
  #get 'pages/indexform1'

  get 'sessions/index'

  get 'users/index'
  post 'pages/create'
  #get 'pages/index'

  #get '/' => 'users#index'
  get '/sign_up' => 'users#index'
  get '/sign_in' => 'pages#index'
  post '/sign_up' => 'users#create'
  post '/sign_in' => 'sessions#create'
  #get '/allusers/sign_up'
  #get '/sign_up' => 'devise/registrations#new'
  #get '/sign_in' => 'devise/sessions#new'
  
  post '/sessions' => 'sessions#create'
  delete  '/logout' => 'sessions#destroy'
  post '/users' => 'users#create'
  get '/dashboard' => 'pages#show'
  #get '/form1' => 'form1#index'
  #get '/form1' => 'teachers#new'
  #post '/formsave' =>'teachers#create'
  
  get '/form1' => 'pages#form1'
  post '/formsave' =>'teachers#create'
  
  get '/musicteacher' => 'musicteachers#index'
  post '/musicteachersave' => 'musicteachers#create'
  delete '/musicteacherdel' => 'musicteachers#delete'
  
  get '/thaimusic' => 'thai_musics#index'
  post '/thaimusicsave' => 'thai_musics#create'
  delete '/thaimusicdel' => 'thai_musics#delete'
  
  get '/intermusic' => 'inter_musics#index'
  post '/intermusicsave' => 'inter_musics#create'
  delete '/intermusicdel' => 'inter_musics#delete'
  
  get '/folkmusic' => 'folk_musics#index'
  post '/folkmusicsave' => 'folk_musics#create'
  delete '/folkmusicdel' => 'folk_musics#delete'
  
  get '/admin' => 'admin#index'
  post '/admin' => 'admin#show'
  get '/adminimport' => 'admin#import'
  post '/adminimport' => 'admin#importpost'
  get '/exportto' => 'admin#exportTo'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "pages#index"
  #root 'devise/sessions#new'
  devise_scope :alluser do
    #root to: "allusers/sessions#new"
    #get "/sign_up" => "allusers/registrations#new"
    #post "/sign_up" => "allusers/registrations#create"
    #get '/sign_in' => "allusers/sessions#new"
    #post '/sign_in' => "allusers/sessions#create"
    #delete  '/logout' => 'allusers/sessions#destroy'
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :schools , only: [:index]
  get "/allschools" => 'users#allschools'
  post "/allschools" => 'users#allschools'
  resources :schools do
    post 'filter', on: :collection
  end
  resources :questions
  resources :users
  resources :answers
  resources :loghistories

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
