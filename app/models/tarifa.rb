class Tarifa < ActiveRecord::Base
  self.table_name = "tarifas"
  attr_accessible :desde,:hasta, :aporte_mantenimiento

  validate do |tarifa|
    tarifa.errors[:base] <<("Campo DESDE es requerido") if tarifa.desde.nil?
    tarifa.errors[:base] <<("Campo HASTA es requerido") if  tarifa.hasta.nil?
    tarifa.errors[:base] <<("Campo APORTE MANTENIMIENTO esrequerido") if tarifa.aporte_bs.nil?

  end


end

