class Medida < ActiveRecord::Base
    has_many :cantidades
    has_many :producto, through: :cantidades
end