Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get 'bets/:sport', :to => 'bets#fetch'
    end
  end
end
