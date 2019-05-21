class CreateWaterings < ActiveRecord::Migration[5.2]
  def change
    create_table :waterings do |t|
      t.integer :plant_id
      t.integer :container_id
      t.integer :vacation_days
      t.string :start_vacation
      t.string :end_vacation
      t.string :date
      t.integer :leftover

      t.timestamps
    end
  end
end
