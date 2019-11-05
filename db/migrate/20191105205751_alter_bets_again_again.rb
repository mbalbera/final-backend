class AlterBetsAgainAgain < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :home_team_spread, :string
    add_column :bets, :away_team_spread, :string
  end
end
