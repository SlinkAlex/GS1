class Medida < ActiveRecord::Base
    has_many :quantity
    has_many :producto, through: :quantity
end