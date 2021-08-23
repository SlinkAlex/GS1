class CreateHasCountries < ActiveRecord::Migration
  def change
    create_table :has_countries do |t|
      t.references :country, index: true
      t.string :producto_id, index: true

      t.timestamps
    end
  end
end
