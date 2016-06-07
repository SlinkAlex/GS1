class CreateTarifas < ActiveRecord::Migration
  def change
    create_table :tarifas do |t|
      t.decimal :desde
      t.decimal :hasta
      t.decimal :aporte_bs
      t.decimal :aporte_ut
      t.integer :usuario
      t.string :tipo_aporte
      t.timestamps
    end
  end
end
