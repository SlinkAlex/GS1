class UnidadesdeMedidas < ActiveRecord::Migration
  def change
    create_table :medidas do |t|
      t.string :codigo
      t.string :nombre
      t.string :abreviatura
      t.timestamps
    end
  end
end
