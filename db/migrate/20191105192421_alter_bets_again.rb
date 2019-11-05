class AlterBetsAgain < ActiveRecord::Migration[6.0]
  def change
      add_column :bets, :home_team_abr, :string
      add_column :bets, :away_team_abr, :string
      add_column :bets, :home_team_name, :string
      add_column :bets, :away_team_name, :string
  end
end
