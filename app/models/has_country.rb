class HasCountry < ActiveRecord::Base
  belongs_to :country
  belongs_to :producto, :foreign_key => "producto_id"
end
