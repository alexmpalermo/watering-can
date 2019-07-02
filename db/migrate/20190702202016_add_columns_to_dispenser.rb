class AddColumnsToDispenser < ActiveRecord::Migration[5.2]
  def change
    add_column :dispensers, :date_refilled, :string
    add_column :dispensers, :current_amount, :integer
  end
end
