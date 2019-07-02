class DropWateringTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :waterings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
