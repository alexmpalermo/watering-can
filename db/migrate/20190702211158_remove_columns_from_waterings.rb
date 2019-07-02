class RemoveColumnsFromWaterings < ActiveRecord::Migration[5.2]
  def change
    remove_column :waterings, :vacation_days, :integer
    remove_column :waterings, :start_vacation, :string
    remove_column :waterings, :end_vacation, :string
  end
end
