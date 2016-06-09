class SeedPermisosTarifas < ActiveRecord::Migration
  def up
    execute "INSERT INTO usuarios_alcances ([perfil],[alcance],[gerencia],[created_at],[updated_at]) VALUES ('Gerente','Ver Tarifas','Comercial','2016-06-08 15:44:54.170','2016-06-08 15:44:54.170')"
    execute "INSERT INTO usuarios_alcances ([perfil],[alcance],[gerencia],[created_at],[updated_at]) VALUES ('Gerente','Crear Tarifas','Comercial','2016-06-08 15:44:54.170','2016-06-08 15:44:54.170')"
    execute "INSERT INTO usuarios_alcances ([perfil],[alcance],[gerencia],[created_at],[updated_at]) VALUES ('Gerente','Editar Tarifas','Comercial','2016-06-08 15:44:54.170','2016-06-08 15:44:54.170')"
    execute "INSERT INTO usuarios_alcances ([perfil],[alcance],[gerencia],[created_at],[updated_at]) VALUES ('Gerente','Eliminar Tarifas','Comercial','2016-06-08 15:44:54.170','2016-06-08 15:44:54.170')"

  end
  def down
  end
end
