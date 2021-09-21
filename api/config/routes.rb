Rails.application.routes.draw do
  resources :venues
  resources :plans
  namespace 'api' do
    namespace 'v1' do
      resources :answers
      get 'log/:user_id', to: 'mypages#log'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
