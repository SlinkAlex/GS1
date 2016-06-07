class SeedTarifas < ActiveRecord::Migration
  def up
    execute "INSERT INTO tarifas ([desde],[hasta],[aporte_bs],[aporte_ut],[usuario], [tipo_aporte]) VALUES (0,100000, 15000 ,8000 ,1, 'Incripcion')"
    execute "INSERT INTO tarifas ([desde],[hasta],[aporte_bs],[aporte_ut],[usuario], [tipo_aporte]) VALUES (100001,5000000, 45000 ,20000 ,1, 'Mantenimiento')"


  end


  def down
  end
end
