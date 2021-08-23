class CreateCantidades < ActiveRecord::Migration
  def change
    create_table :cantidades do |t|
      t.integer :unidades
      t.integer :producto_id
      t.integer :medida_id
      t.timestamps
    end
  end
end
