class AddEscalaToEmpresasRegistradas < ActiveRecord::Migration
  def change
    add_column :empresas_registradas, :escala, :string
  end
end
