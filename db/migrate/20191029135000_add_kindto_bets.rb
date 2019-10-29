class AddKindtoBets < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :kind_of_bet, :string
  end
end
