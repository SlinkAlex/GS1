class AgregarTarifaEmpresaRegistrada < ActiveRecord::Migration
  def change
    add_column :empresas_registradas, :id_tarifa, :integer

  end
end
