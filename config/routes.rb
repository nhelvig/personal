Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  get '/pics' => 'application#pics.html.erb'
  get '/review' => 'application#review.html.erb'
  get '/investmentTracker' => 'investment_tracker#index'
  get '/investmentTracker/reset' => 'investment_tracker#destroy'
  get '/investmentTracker/new' => 'investment_tracker#new'
  post '/investmentTracker' => 'investment_tracker#create'
  post '/mail' => 'welcome#mail'
  
  resources :articles
  resources :transactions

  resources :transactions do
    collection { post :import }
  end
end
