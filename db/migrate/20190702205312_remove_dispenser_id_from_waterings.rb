class RemoveDispenserIdFromWaterings < ActiveRecord::Migration[5.2]
  def change
    remove_column :waterings, :dispenser_id, :integer
  end
end
