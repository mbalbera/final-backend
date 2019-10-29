class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.string :category
      t.string :line
      t.string :text
      t.string :time
      t.string :status
    end
  end
end
