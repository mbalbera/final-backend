Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get 'bets/fetch/:sport', :to => 'bets#fetch_by_sport'
      get 'bets/:sport', :to => 'bets#index'
    end
  end
end
