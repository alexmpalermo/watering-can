class RenameColumnWatering < ActiveRecord::Migration[5.2]
  def change
    rename_column :waterings, :container_id, :dispenser_id
  end
end
