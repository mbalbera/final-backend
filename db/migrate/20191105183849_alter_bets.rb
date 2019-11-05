class AlterBets < ActiveRecord::Migration[6.0]
  def change
     add_column :bets, :over_home_value, :integer
     add_column :bets, :under_away_value, :integer
  end
  
end
