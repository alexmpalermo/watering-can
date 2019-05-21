class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.integer :dispenser_id
      t.string :date
      t.integer :start_amount

      t.timestamps
    end
  end
end
