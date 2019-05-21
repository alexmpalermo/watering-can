class CreateDispensers < ActiveRecord::Migration[5.2]
  def change
    create_table :dispensers do |t|
      t.integer :user_id
      t.integer :product_number
      t.integer :capacity
      t.string :name

      t.timestamps
    end
  end
end
