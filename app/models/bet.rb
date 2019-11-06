class Bet < ApplicationRecord

    has_many :user_bets
    has_many :users, through: :user_bets

end