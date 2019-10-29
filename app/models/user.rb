class User < ApplicationRecord
    has_many :user_bets
    has_many :bets, through: :user_bets

    has_secure_password
    validates :name, uniqueness: { case_sensitive: false }
    validates :name, :password, presence: true
end