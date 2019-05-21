class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.integer :dispenser_id
      t.string :name
      t.string :location
      t.integer :water_quantity
      t.integer :water_frequency
      t.string :last_day_watered
      t.string :next_water_day
      t.boolean :needs_water

      t.timestamps
    end
  end
end
