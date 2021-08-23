class Country < ActiveRecord::Base
  has_many :has_country
  has_many :producto, through: :has_country
end