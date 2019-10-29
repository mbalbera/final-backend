class CreateUserBets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_bets do |t|
      t.references :user
      t.references :bet
      t.integer :risk_amt
      t.timestamps
    end
  end
end
