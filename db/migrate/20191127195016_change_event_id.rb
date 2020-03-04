class ChangeEventId < ActiveRecord::Migration[6.0]
  def change
    remove_column :bets, :event_id
    add_column :bets, :event_id, :bigint
  end
end
