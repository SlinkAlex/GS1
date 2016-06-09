class SeedTarifas < ActiveRecord::Migration
  def up
    execute "INSERT INTO tarifas ([desde],[hasta],[aporte_bs],[tipo_aporte], [id_tipo_usuario]) VALUES (0,100000, 15000  ,'Inscripcion', 1)"
    execute "INSERT INTO tarifas ([desde],[hasta],[aporte_bs],[tipo_aporte], [id_tipo_usuario]) VALUES (100001,5000000,20000 ,'Mantenimiento', 2)"
  end
  def down
  end
end
