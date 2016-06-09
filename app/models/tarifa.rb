class Tarifa < ActiveRecord::Base
  self.table_name = "tarifas"
  attr_accessible :desde,:hasta, :aporte_bs, :tipo_aporte, :id_tipo_usuario
  belongs_to :tipo_usuario_empresa, :foreign_key =>  "id_tipo_usuario"

  validates_numericality_of :desde, :on => :create , :message =>" - Es un campo numerico"
  validates_numericality_of :hasta, :on => :create , :message =>" - Es un campo numerico"
  validates_numericality_of :aporte_bs, :on => :create , :message =>" - Debe ingresar un monto"

  validate do |tarifa|
    tarifa.errors[:base] <<("El Campo DESDE es requerido") if tarifa.desde.nil?
    tarifa.errors[:base] <<("El Campo HASTA es requerido") if  tarifa.hasta.nil?
    tarifa.errors[:base] <<("El Campo APORTE DE MANTENIMIENTO es requerido") if  tarifa.aporte_bs.nil?
    tarifa.errors[:base] <<("El Campo TIPO DE USUARIO es requerido") if  tarifa.id_tipo_usuario.nil?

  end


end

