class Cantidades < ActiveRecord::Base
    belongs_to :medida
    belongs_to :producto, :foreign_key => "producto_id"
end