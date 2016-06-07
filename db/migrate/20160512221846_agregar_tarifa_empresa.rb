class AgregarTarifaEmpresa < ActiveRecord::Migration
  def change
    add_column :empresa, :id_tarifa, :integer
  end
end
