class AddDispToWatering < ActiveRecord::Migration[5.2]
  def change
    add_column :waterings, :dispenser_id, :integer
  end
end
