# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20210818175627) do

  create_table "auditoria", force: true do |t|
    t.string   "usuario"
    t.string   "accion"
    t.string   "tabla"
    t.datetime "fecha_accion"
    t.text     "descripcion"
  end

  create_table "cantidades", force: true do |t|
    t.integer  "unidades"
    t.integer  "producto_id"
    t.integer  "medida_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cargo", force: true do |t|
    t.string  "descripcion"
    t.integer "habilitado"
  end

  create_table "ciudad", force: true do |t|
    t.string  "nombre"
    t.integer "id_estado"
    t.integer "habilitado"
  end

  create_table "classifications", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "codes", id: false, force: true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iso",        limit: 2
    t.string   "lang_code",  limit: 10
  end

  create_table "countries2", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iso",        limit: 2
    t.string   "lang_code",  limit: 10
  end

  create_table "empresa", primary_key: "prefijo", force: true do |t|
    t.text     "nombre_empresa"
    t.datetime "fecha_inscripcion"
    t.text     "direccion_empresa"
    t.integer  "id_estado"
    t.integer  "id_ciudad"
    t.string   "rif",                                        limit: 20
    t.integer  "id_estatus"
    t.string   "id_tipo_usuario"
    t.text     "nombre_comercial"
    t.integer  "id_clasificacion"
    t.string   "categoria",                                  limit: 10
    t.integer  "division"
    t.integer  "grupo"
    t.integer  "clase"
    t.text     "rep_legal"
    t.text     "cargo_rep_legal"
    t.text     "circunscripcion_judicial"
    t.integer  "numero_registro_mercantil"
    t.string   "tomo_registro_mercantil"
    t.string   "nit_registro_mercantil"
    t.string   "nacionalidad_responsable_legal"
    t.string   "domicilio_responsable_legal"
    t.string   "cedula_responsable_legal"
    t.string   "ventas_brutas_anuales"
    t.datetime "fecha_registro_mercantil"
    t.integer  "id_subestatus"
    t.datetime "fecha_activacion"
    t.integer  "id_motivo_retiro"
    t.datetime "fecha_retiro"
    t.float    "aporte_mantenimiento_ut",                    limit: 24
    t.float    "aporte_mantenimiento_bs",                    limit: 24
    t.integer  "id_parroquia_empresa"
    t.text     "parroquia_empresa"
    t.text     "contacto_tlf2"
    t.text     "contacto_tlf3"
    t.text     "contacto_fax"
    t.text     "contacto_email1"
    t.text     "contacto_email2"
    t.integer  "user_ult_modificacion"
    t.datetime "fecha_ultima_modificacion"
    t.text     "rep_ean_cargo"
    t.text     "direccion_ean1"
    t.text     "direccion_ean2"
    t.text     "direccion_ean3"
    t.text     "direccion_ean4"
    t.text     "punto_ref_ean"
    t.integer  "id_estado_ean"
    t.integer  "id_ciudad_ean"
    t.integer  "id_parroquia_ean"
    t.text     "parroquia_ean"
    t.text     "cod_postal_ean"
    t.text     "codigo_postal_empresa"
    t.text     "telefono1_ean"
    t.text     "telefono2_ean"
    t.text     "telefono3_ean"
    t.text     "fax_ean"
    t.text     "email1_ean"
    t.text     "email2_ean"
    t.text     "rep_edi"
    t.text     "rep_edi_cargo"
    t.text     "direccion_edi1"
    t.text     "direccion_edi2"
    t.text     "direccion_edi3"
    t.integer  "id_ciudad_edi"
    t.text     "punto_ref_edi"
    t.text     "codigo_postal_edi"
    t.text     "telefono1_edi"
    t.text     "telefono2_edi"
    t.text     "telefono3_edi"
    t.text     "fax_edi"
    t.text     "email1_edi"
    t.integer  "usuario_ultima_modificacion_edi"
    t.datetime "fecha_ultima_modificacion_edi"
    t.integer  "user_crea_edi"
    t.float    "aporte_mantenimiento",                       limit: 53
    t.integer  "id_municipio_ean"
    t.integer  "id_municipio_edi"
    t.integer  "id_parroquia_edi"
    t.string   "rep_mercadeo"
    t.string   "rep_mercadeo_cargo"
    t.string   "direccion_mercadeo1"
    t.string   "direccion_mercadeo2"
    t.string   "direccion_mercadeo3"
    t.string   "punto_referencia_mercadeo"
    t.integer  "id_ciudad_mercadeo"
    t.string   "codigo_postal_mercadeo"
    t.string   "telefono1_mercadeo"
    t.string   "telefono2_mercadeo"
    t.string   "fax_mercadeo"
    t.string   "email_mercadeo"
    t.integer  "id_municipio_mercadeo"
    t.string   "rep_recursos"
    t.string   "rep_recursos_cargo"
    t.string   "direccion_recursos1"
    t.string   "direccion_recursos2"
    t.string   "direccion_recursos3"
    t.string   "punto_referencia_recursos"
    t.integer  "id_ciudad_recursos"
    t.string   "codigo_postal_recursos"
    t.string   "telefono1_recursos"
    t.string   "telefono2_recursos"
    t.string   "fax_recursos"
    t.string   "email_recursos"
    t.integer  "id_municipio_recursos"
    t.integer  "id_parroquia_recursos"
    t.string   "parroquia_recursos"
    t.string   "punto_referencia_empresa"
    t.datetime "fecha_ultima_modificacion_ean"
    t.datetime "fecha_ultima_modificacion_recursos"
    t.datetime "fecha_ultima_modificacion_mercadeo"
    t.string   "contacto_tlf1"
    t.text     "rep_ean"
    t.string   "codigo_upc"
    t.integer  "user_crea"
    t.string   "parroquia_edi"
    t.integer  "id_estado_edi"
    t.text     "direccion_ean"
    t.text     "direccion_edi"
    t.text     "direccion_mercadeo"
    t.text     "direccion_recursos"
    t.string   "tipo_rif"
    t.string   "rif_completo"
    t.string   "tipo_galpon_edificio_quinta"
    t.string   "galpon_edificio_quinta"
    t.string   "tipo_oficina_apartamento"
    t.string   "oficina_apartamento"
    t.string   "tipo_avenida_calle"
    t.string   "avenida_calle"
    t.string   "tipo_urbanizacion_barrio_sector"
    t.string   "urbanizacion_barrio_sector"
    t.string   "tipo_piso_numero"
    t.string   "piso_numero"
    t.string   "tipo_galpon_edificio_quinta_sincronet"
    t.string   "galpon_edificio_quinta_sincronet"
    t.string   "tipo_oficina_apartamento_sincronet"
    t.string   "oficina_apartamento_sincronet"
    t.string   "tipo_avenida_calle_sincronet"
    t.string   "avenida_calle_sincronet"
    t.string   "tipo_urbanizacion_barrio_sector_sincronet"
    t.string   "urbanizacion_barrio_sector_sincronet"
    t.string   "tipo_piso_numero_sincronet"
    t.string   "piso_numero_sincronet"
    t.string   "tipo_galpon_edificio_quinta_seminarios"
    t.string   "galpon_edificio_quinta_seminarios"
    t.string   "tipo_oficina_apartamento_seminarios"
    t.string   "oficina_apartamento_seminarios"
    t.string   "tipo_avenida_calle_seminarios"
    t.string   "avenida_calle_seminarios"
    t.string   "tipo_urbanizacion_barrio_sector_seminarios"
    t.string   "urbanizacion_barrio_sector_seminarios"
    t.string   "tipo_piso_numero_seminarios"
    t.string   "piso_numero_seminarios"
    t.string   "tipo_galpon_edificio_quinta_mercadeo"
    t.string   "galpon_edificio_quinta_mercadeo"
    t.string   "tipo_oficina_apartamento_mercadeo"
    t.string   "oficina_apartamento_mercadeo"
    t.string   "tipo_avenida_calle_mercadeo"
    t.string   "avenida_calle_mercadeo"
    t.string   "tipo_urbanizacion_barrio_sector_mercadeo"
    t.string   "urbanizacion_barrio_sector_mercadeo"
    t.string   "tipo_piso_numero_mercadeo"
    t.string   "piso_numero_mercadeo"
    t.integer  "id_estado_mercadeo"
    t.string   "parroquia_mercadeo"
    t.string   "punto_ref_mercadeo"
    t.string   "telefono3_mercadeo"
    t.string   "email2_edi"
    t.string   "email2_recursos"
    t.string   "email2_mercadeo"
    t.string   "email1_recursos"
    t.string   "email1_mercadeo"
    t.string   "telefono3_recursos"
    t.integer  "id_estado_recursos"
    t.string   "punto_ref_recursos"
    t.string   "cod_contacto_tlf1"
    t.string   "cod_contacto_tlf3"
    t.string   "cod_contacto_tlf2"
    t.string   "cod_contacto_fax"
    t.string   "cod_tlf1_ean"
    t.string   "cod_tlf2_ean"
    t.string   "cod_tlf3_ean"
    t.string   "cod_fax_ean"
    t.string   "cod_tlf1_sincronet"
    t.string   "cod_tlf2_sincronet"
    t.string   "cod_tlf3_sincronet"
    t.string   "cod_fax_sincronet"
    t.string   "cod_tlf1_seminarios"
    t.string   "cod_tlf2_seminarios"
    t.string   "cod_tlf3_seminarios"
    t.string   "cod_fax_seminarios"
    t.string   "cod_tlf1_mercadeo"
    t.string   "cod_tlf2_mercadeo"
    t.string   "cod_tlf3_mercadeo"
    t.string   "cod_fax_mercadeo"
    t.string   "contacto_tlf1_completo"
    t.string   "contacto_tlf3_completo"
    t.string   "contacto_fax_completo"
    t.string   "telefono1_ean_completo"
    t.string   "telefono2_ean_completo"
    t.string   "telefono3_ean_completo"
    t.string   "fax_ean_completo"
    t.string   "contacto_tlf2_completo"
    t.datetime "fecha_reactivacion"
    t.boolean  "no_rif_validation"
    t.integer  "id_tarifa"
    t.string   "escala"
  end

  create_table "empresa_clasificacion", force: true do |t|
    t.string  "categoria",   limit: 11
    t.integer "division"
    t.integer "grupo"
    t.integer "clase"
    t.string  "descripcion", limit: 150
    t.integer "habilitado"
  end

  create_table "empresa_eliminada", primary_key: "prefijo", force: true do |t|
    t.string   "nombre_empresa"
    t.string   "rif",                     limit: 15
    t.string   "rep_legal"
    t.string   "contacto_tlf1"
    t.string   "contacto_email1"
    t.integer  "id_estatus"
    t.integer  "id_motivo_retiro"
    t.string   "categoria",               limit: 1
    t.string   "division",                limit: 2
    t.string   "grupo",                   limit: 3
    t.string   "clase",                   limit: 4
    t.integer  "id_tipo_usuario_empresa"
    t.datetime "fecha_retiro"
    t.datetime "fecha_eliminacion"
    t.integer  "no_elegible",             limit: 1
  end

  add_index "empresa_eliminada", ["fecha_eliminacion"], name: "indice_fecha_eliminacion"
  add_index "empresa_eliminada", ["prefijo"], name: "indice_prefijo"

  create_table "empresa_servicios", force: true do |t|
    t.integer  "prefijo"
    t.integer  "id_servicio"
    t.datetime "fecha_contratacion"
    t.datetime "fecha_finalizacion"
    t.string   "nombre_contacto",    limit: 40
    t.string   "cargo_contacto",     limit: 40
    t.string   "telefono"
    t.string   "email",              limit: 60
  end

  create_table "empresas_registradas", force: true do |t|
    t.string   "nombre_empresa"
    t.datetime "fecha_inscripcion"
    t.string   "direccion_empresa"
    t.integer  "id_estado"
    t.integer  "id_ciudad"
    t.string   "rif",                                        limit: 20
    t.integer  "id_estatus"
    t.string   "id_tipo_usuario"
    t.string   "nombre_comercial"
    t.integer  "id_clasificacion"
    t.string   "categoria",                                  limit: 10
    t.integer  "division"
    t.integer  "grupo"
    t.integer  "clase"
    t.string   "rep_legal"
    t.string   "cargo_rep_legal"
    t.string   "circunscripcion_judicial"
    t.integer  "numero_registro_mercantil"
    t.string   "tomo_registro_mercantil"
    t.string   "nacionalidad_responsable_legal"
    t.string   "domicilio_responsable_legal"
    t.string   "cedula_responsable_legal"
    t.string   "ventas_brutas_anuales"
    t.float    "aporte_mantenimiento",                       limit: 53
    t.datetime "fecha_registro_mercantil"
    t.integer  "id_parroquia_empresa"
    t.string   "parroquia_empresa"
    t.string   "contacto_tlf2"
    t.string   "contacto_tlf3"
    t.string   "contacto_fax"
    t.string   "contacto_email1"
    t.string   "contacto_email2"
    t.datetime "fecha_ultima_modificacion"
    t.string   "rep_ean_cargo"
    t.string   "punto_ref_ean"
    t.integer  "id_estado_ean"
    t.integer  "id_ciudad_ean"
    t.integer  "id_parroquia_ean"
    t.string   "parroquia_ean"
    t.string   "cod_postal_ean"
    t.string   "telefono1_ean"
    t.string   "telefono2_ean"
    t.string   "telefono3_ean"
    t.string   "fax_ean"
    t.string   "email1_ean"
    t.string   "email2_ean"
    t.string   "rep_edi"
    t.string   "rep_edi_cargo"
    t.integer  "id_ciudad_edi"
    t.string   "punto_ref_edi"
    t.string   "codigo_postal_edi"
    t.string   "telefono1_edi"
    t.string   "telefono2_edi"
    t.string   "telefono3_edi"
    t.string   "fax_edi"
    t.string   "email1_edi"
    t.integer  "id_municipio_ean"
    t.integer  "id_municipio_edi"
    t.integer  "id_parroquia_edi"
    t.string   "rep_mercadeo"
    t.string   "rep_mercadeo_cargo"
    t.string   "telefono1_mercadeo"
    t.string   "fax_mercadeo"
    t.string   "email_mercadeo"
    t.string   "rep_recursos"
    t.string   "rep_recursos_cargo"
    t.string   "telefono1_recursos"
    t.string   "fax_recursos"
    t.string   "email_recursos"
    t.string   "contacto_tlf1"
    t.string   "rep_ean"
    t.string   "parroquia_edi"
    t.integer  "id_estado_edi"
    t.text     "direccion_ean"
    t.text     "direccion_edi"
    t.integer  "id_subestatus"
    t.integer  "prefijo"
    t.float    "aporte_mantenimiento_bs",                    limit: 24
    t.string   "tipo_rif"
    t.string   "rif_completo"
    t.string   "tipo_galpon_edificio_quinta"
    t.string   "galpon_edificio_quinta"
    t.string   "tipo_oficina_apartamento"
    t.string   "oficina_apartamento"
    t.string   "tipo_avenida_calle"
    t.string   "avenida_calle"
    t.string   "tipo_urbanizacion_barrio_sector"
    t.string   "urbanizacion_barrio_sector"
    t.string   "tipo_piso_numero"
    t.string   "piso_numero"
    t.string   "tipo_galpon_edificio_quinta_sincronet"
    t.string   "galpon_edificio_quinta_sincronet"
    t.string   "tipo_oficina_apartamento_sincronet"
    t.string   "oficina_apartamento_sincronet"
    t.string   "tipo_avenida_calle_sincronet"
    t.string   "avenida_calle_sincronet"
    t.string   "tipo_urbanizacion_barrio_sector_sincronet"
    t.string   "urbanizacion_barrio_sector_sincronet"
    t.string   "tipo_piso_numero_sincronet"
    t.string   "piso_numero_sincronet"
    t.string   "tipo_galpon_edificio_quinta_seminarios"
    t.string   "galpon_edificio_quinta_seminarios"
    t.string   "tipo_oficina_apartamento_seminarios"
    t.string   "oficina_apartamento_seminarios"
    t.string   "tipo_avenida_calle_seminarios"
    t.string   "avenida_calle_seminarios"
    t.string   "tipo_urbanizacion_barrio_sector_seminarios"
    t.string   "urbanizacion_barrio_sector_seminarios"
    t.string   "tipo_piso_numero_seminarios"
    t.string   "piso_numero_seminarios"
    t.string   "tipo_galpon_edificio_quinta_mercadeo"
    t.string   "galpon_edificio_quinta_mercadeo"
    t.string   "tipo_oficina_apartamento_mercadeo"
    t.string   "oficina_apartamento_mercadeo"
    t.string   "tipo_avenida_calle_mercadeo"
    t.string   "avenida_calle_mercadeo"
    t.string   "tipo_urbanizacion_barrio_sector_mercadeo"
    t.string   "urbanizacion_barrio_sector_mercadeo"
    t.string   "tipo_piso_numero_mercadeo"
    t.string   "piso_numero_mercadeo"
    t.integer  "id_estado_mercadeo"
    t.integer  "id_ciudad_mercadeo"
    t.integer  "id_municipio_mercadeo"
    t.string   "parroquia_mercadeo"
    t.string   "punto_ref_mercadeo"
    t.string   "codigo_postal_mercadeo"
    t.string   "telefono2_mercadeo"
    t.string   "telefono3_mercadeo"
    t.string   "email2_edi"
    t.string   "email2_recursos"
    t.string   "email2_mercadeo"
    t.string   "email1_recursos"
    t.string   "email1_mercadeo"
    t.string   "telefono2_recursos"
    t.string   "telefono3_recursos"
    t.integer  "id_estado_recursos"
    t.integer  "id_ciudad_recursos"
    t.integer  "id_municipio_recursos"
    t.string   "parroquia_recursos"
    t.string   "punto_ref_recursos"
    t.string   "codigo_postal_recursos"
    t.string   "cod_contacto_tlf1"
    t.string   "cod_contacto_tlf2"
    t.string   "cod_contacto_tlf3"
    t.string   "cod_contacto_fax"
    t.string   "cod_tlf1_ean"
    t.string   "cod_tlf2_ean"
    t.string   "cod_tlf3_ean"
    t.string   "cod_fax_ean"
    t.string   "cod_tlf1_sincronet"
    t.string   "cod_tlf2_sincronet"
    t.string   "cod_tlf3_sincronet"
    t.string   "cod_fax_sincronet"
    t.string   "cod_tlf1_seminarios"
    t.string   "cod_tlf2_seminarios"
    t.string   "cod_tlf3_seminarios"
    t.string   "cod_fax_seminarios"
    t.string   "cod_tlf1_mercadeo"
    t.string   "cod_tlf2_mercadeo"
    t.string   "cod_tlf3_mercadeo"
    t.string   "cod_fax_mercadeo"
    t.string   "contacto_tlf1_completo"
    t.string   "contacto_tlf2_completo"
    t.string   "contacto_tlf3_completo"
    t.string   "contacto_fax_completo"
    t.string   "telefono1_ean_completo"
    t.string   "telefono2_ean_completo"
    t.string   "telefono3_ean_completo"
    t.string   "fax_ean_completo"
    t.boolean  "no_rif_validation"
    t.integer  "id_tarifa"
    t.string   "escala"
  end

  create_table "empresas_retiradas", force: true do |t|
    t.integer  "prefijo"
    t.integer  "id_usuario"
    t.datetime "fecha_retiro"
    t.integer  "id_motivo_retiro"
    t.integer  "id_subestatus"
  end

  create_table "estados", force: true do |t|
    t.string  "nombre"
    t.integer "habilitado"
    t.integer "id_pais"
  end

  create_table "estatus", force: true do |t|
    t.string  "descripcion"
    t.integer "habilitado"
    t.string  "alcance",     limit: 15
  end

  create_table "gerencias", force: true do |t|
    t.string  "nombre",     limit: 60
    t.integer "habilitado"
  end

  create_table "gln", primary_key: "gln", force: true do |t|
    t.integer "prefijo"
    t.string  "id_tipo_gln"
    t.string  "codigo_localizacion"
    t.string  "descripcion"
    t.string  "edificio"
    t.string  "avenida"
    t.string  "urbanizacion"
    t.string  "punto_referencia"
    t.string  "municipio"
    t.string  "codigo_postal"
    t.string  "ciudad"
    t.string  "estado"
    t.string  "id_estatus"
    t.string  "fecha_asignacion"
  end

  create_table "has_countries", force: true do |t|
    t.integer  "country_id"
    t.string   "producto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "has_countries", ["country_id"], name: "index_has_countries_on_country_id"

  create_table "historico_empresas_eliminadas", id: false, force: true do |t|
    t.integer  "prefijo"
    t.string   "nombre_empresa"
    t.string   "rif"
    t.string   "rep_legal"
    t.string   "contacto_tlf1"
    t.string   "contacto_email1"
    t.datetime "fecha_liberacion_prefijo"
  end

  create_table "language", id: false, force: true do |t|
    t.string "lang",      limit: 50
    t.string "langType",  limit: 3
    t.string "territory", limit: 3
    t.string "country",   limit: 150
  end

  create_table "medidas", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "abreviatura"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motivo_retiro", force: true do |t|
    t.text    "descripcion"
    t.integer "habilitado"
  end

  create_table "municipio", force: true do |t|
    t.string  "nombre"
    t.string  "ciudad_sede"
    t.integer "id_estado"
    t.integer "habilitado"
  end

  create_table "pais", force: true do |t|
    t.string  "nombre",     limit: 50
    t.integer "habilitado"
  end

  create_table "parroquia", force: true do |t|
    t.text    "nombre"
    t.integer "id_municipio"
    t.integer "habilitado"
  end

  create_table "perfil_usuario_int", force: true do |t|
    t.string  "descripcion"
    t.string  "detalle"
    t.integer "habilitado"
    t.integer "id_gerencia"
  end

  create_table "producto", primary_key: "gtin", force: true do |t|
    t.integer  "prefijo"
    t.string   "codigo_prod",               limit: 5
    t.string   "codigo_upc",                limit: 6
    t.string   "marca"
    t.string   "descripcion"
    t.datetime "fecha_creacion"
    t.datetime "fecha_retiro"
    t.datetime "fecha_ultima_modificacion"
    t.integer  "id_tipo_gtin"
    t.integer  "id_estatus"
    t.integer  "gpc"
    t.integer  "classification_id"
    t.string   "img_url"
    t.integer  "origen",                              default: 1
  end

  add_index "producto", ["classification_id"], name: "index_producto_on_classification_id"
  add_index "producto", ["prefijo"], name: "indice_prefijo"

  create_table "servicios", force: true do |t|
    t.text    "nombre"
    t.integer "habilitado"
  end

  create_table "sub_estatus", force: true do |t|
    t.string  "descripcion", limit: 50
    t.integer "habilitado"
  end

  create_table "tarifas", force: true do |t|
    t.decimal  "desde",           precision: 18, scale: 0
    t.decimal  "hasta",           precision: 18, scale: 0
    t.decimal  "aporte_bs",       precision: 18, scale: 0
    t.integer  "id_tipo_usuario"
    t.string   "tipo_aporte"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_gln", force: true do |t|
    t.string  "nombre",     limit: 30
    t.integer "habilitado"
  end

  create_table "tipo_gtin", force: true do |t|
    t.string  "tipo",       limit: 12
    t.string  "base",       limit: 12
    t.integer "habilitado"
  end

  create_table "tipo_usuario_empresa", id: false, force: true do |t|
    t.integer "id_tipo_usu_empresa"
    t.string  "descripcion"
    t.integer "habilitado"
  end

  create_table "usuario_interno", force: true do |t|
    t.string   "username",        limit: 30
    t.string   "password"
    t.text     "nombre_apellido"
    t.text     "email"
    t.integer  "id_perfil"
    t.integer  "id_gerencia"
    t.integer  "id_cargo"
    t.datetime "fecha_creacion"
    t.string   "password_salt"
  end

  create_table "usuarios_alcances", force: true do |t|
    t.string   "perfil"
    t.string   "alcance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "gerencia"
  end

end
