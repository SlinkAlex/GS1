class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :producto, :origen
  end
end
