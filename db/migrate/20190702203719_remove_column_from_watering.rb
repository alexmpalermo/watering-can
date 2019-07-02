class RemoveColumnFromWatering < ActiveRecord::Migration[5.2]
  def change
    remove_column :waterings, :container_id
  end
end
