class AddEscalaToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresa, :escala, :string
  end
end
