class AddColumnsVacaToDispenser < ActiveRecord::Migration[5.2]
  def change
    add_column :dispensers, :vacation_days, :integer
    add_column :dispensers, :end_vacation, :string
    add_column :dispensers, :start_vacation, :string
  end
end
