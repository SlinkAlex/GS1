class DeleteCantidades < ActiveRecord::Migration
  def change
    drop_table :cantidades
  end
end
