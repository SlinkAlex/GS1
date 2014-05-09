class EmpresaElimDetalle < ActiveRecord::Base
  attr_accessible :fecha_eliminacion, :id_usuario, :prefijo
  self.table_name = "empresa_elim_detalle"  # El nombre de la tabla que se esta mapeando
  belongs_to :empresa_eliminada, :foreign_key => "prefijo"
end
