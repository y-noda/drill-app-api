Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users
      get '/userlist', to: 'users#userlist'
      resources :answers
      get 'log/:user_id', to: 'mypages#log'

      post '/login', to: 'sessions#login'
      delete '/logout', to: 'sessions#logout'

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
