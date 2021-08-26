class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.string :units
      t.string :producto_id
      t.string :medida_id
    end
  end
end
