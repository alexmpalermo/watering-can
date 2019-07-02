class DropContainersTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :containers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
