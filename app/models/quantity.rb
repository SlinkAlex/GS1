class Quantity < ActiveRecord::Base
    belongs_to :medida, :foreign_key => "medida_id"
    belongs_to :producto, :foreign_key => "producto_id"
end