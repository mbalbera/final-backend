class AddEventIDtoBets < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :event_id, :integer
  end
end
