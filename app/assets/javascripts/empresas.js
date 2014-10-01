  $( document ).ready(function() {
        
        // Datatable que maneja el listado de empresas
        $("#data_table_empresas").dataTable({
            sPaginationType: "full_numbers",
            aoColumns: [ null,  null, null,  null, null, { "bSortable": false }, null, { "bSortable": false },{ "bSortable": false },{ "bSortable": false },{ "bSortable": false },{ "bSortable": false }],
            aaSorting: [[ 2, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas').data('source')
        }).columnFilter({ aoColumns: [{ type: "text"}, {type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, null, {type: "text"}]});



        $('#data_table_empresas input').attr("placeholder", "Buscar");


         // Datatable que maneja el listado de empresas activacion
        $("#data_table_empresas_activacion").dataTable({
            sPaginationType: "full_numbers",
            aoColumns: [ { "bSortable": false },  null, null,  null, null, null, null, null, null, null, { "bSortable": false } ],
            aaSorting: [[ 3, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_activacion').data('source')
        }).columnFilter({ aoColumns: [null, {type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, null,{type: "text"}, {type: "text"}, {type: "text"} ]});

        $('#data_table_empresas_activacion input').attr("placeholder", "Buscar");

        $("#data_table_empresas_sub_estatus").dataTable({
            sPaginationType: "full_numbers",
            aaSorting: [[ 2, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_sub_estatus').data('source')
        }).columnFilter({ aoColumns: [null, { type: "text"}, {type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, null, {type: "text"}]});

        // Datatable que maneja el listado para retirar empresas
        $("#data_table_empresas_retirar").dataTable({
            sPaginationType: "full_numbers",
            aaSorting: [[ 2, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_retirar').data('source')
        }).columnFilter({ aoColumns: [null, {type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}]});

        $('#data_table_empresas_retirar input').attr("placeholder", "Buscar");

        // Datatable que maneja el listado para empresas retiradas
        $("#data_table_empresas_retiradas").dataTable({
            sPaginationType: "full_numbers",
            aaSorting: [[ 5, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_retiradas').data('source')
        }).columnFilter({ aoColumns: [{type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"},null,null,null,null]});

        $('#data_table_empresas_retiradas input').attr("placeholder", "Buscar");

        // Datatable que maneja el listado para empresas eliminar
        $("#data_table_empresas_eliminar").dataTable({
            sPaginationType: "full_numbers",
            aaSorting: [[ 5, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_eliminar').data('source')
        }).columnFilter({ aoColumns: [null, {type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"},null, null,null,null, null]});

        $('#data_table_empresas_eliminar input').attr("placeholder", "Buscar");

        // Datatable que maneja el listado para empresas eliminar
        $("#data_table_empresas_eliminadas").dataTable({
            sPaginationType: "full_numbers",
            aaSorting: [[ 5, "desc" ]],
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',
            sAjaxSource: $('#data_table_empresas_eliminadas').data('source')
        }).columnFilter({ aoColumns: [{type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"},null,null,null,null, {type: "text"}, {type: "text"}]});

        $('#data_table_empresas_eliminadas input').attr("placeholder", "Buscar");

        
        if (window.location.pathname.split('/')[3] != 'edit')
        {
            $("#empresa_fecha_registro_mercantil").datepicker();
        }

        // Actualizar la ciudad dependiendo del estado seleccionado - Datos Basicos
        $( "#empresa_id_estado").change(function() {
        	
        	//AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
        	$.get("/ciudades.json?id_estado="+$(this).val(), function( data ) { 
 				var ciudades = $("#empresa_id_ciudad");
 				ciudades.empty() // Se eliminan las opciones del select ciudades
 				
 				$.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
  					ciudades.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
				});
        	});
           

		});

        $( "#empresa_id_estado_ean").change(function() {
            
            
            //AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
            $.get("/ciudades.json?id_estado="+$(this).val(), function( data ) { 
                var ciudades = $("#empresa_id_ciudad_ean");
                ciudades.empty() // Se eliminan las opciones del select ciudades
                
                $.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
                    ciudades.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
                });
            });

            //AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
            $.get("/municipios.json?id_estado="+$(this).val(), function( data ) { 
                var  municipios = $("#empresa_id_municipio_ean");
                municipios.empty() // Se eliminan las opciones del select ciudades
                
                $.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
                    municipios.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
                });
            });       

        });


        $( "#empresa_id_estado_edi").change(function() {
            
            //AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
            $.get("/ciudades.json?id_estado="+$(this).val(), function( data ) { 
                var ciudades = $("#empresa_id_ciudad_edi");
                ciudades.empty() // Se eliminan las opciones del select ciudades
                
                $.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
                    ciudades.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
                });
            });

            //AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
            $.get("/municipios.json?id_estado="+$(this).val(), function( data ) { 
                var  municipios = $("#empresa_id_municipio_edi");
                municipios.empty() // Se eliminan las opciones del select ciudades
                
                $.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
                    municipios.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
                });
            });
 
            
                      

        });




        // Verificar el cambio del select  estado de la correspondencia
		$( "#empresa_correspondencia_attributes_id_estado").change(function() {
        	
        	//AJAX que obtiene las ciudades dependiendo Que cumplen la condicion del estado seleccioando
        	$.get("/ciudades.json?id_estado="+$(this).val(), function( data ) { 
 				var correspondencia_ciudades = $("#empresa_correspondencia_attributes_id_ciudad");
 				correspondencia_ciudades.empty() // Se eliminan las opciones del select ciudades
 				
 				$.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
  					correspondencia_ciudades.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
				});
        	})

            //AJAX que obtiene las municpios dependiendo Que cumplen la condicion del estado seleccioando
            $.get("/municipios.json?id_estado="+$(this).val(), function( data ) { 
                var municipios = $("#empresa_correspondencia_attributes_id_municipio");
                municipios.empty() // Se eliminan las opciones del select ciudades
                
                $.each( data, function( key, value ) {  // Se itera sobre las ciudades del estado seleccionado
                    municipios.append('<option value="'+ value.id +'">'+value.nombre+'</option>') // Se agregan las ciudades al select
                });
            })
		});

        //  Manejador del evento Change del campo Clasificacion
        $( "#empresa_id_clasificacion").change(function() {
            $.get('/clasificaciones/'+$(this).val()+'.json', function( data ) {
                $('#empresa_categoria').val(data.categoria); // campo categoria formulario crear Empresa
                $('#empresa_division').val(data.division); // campo division formulario crear Empresa
                $('#empresa_grupo').val(data.grupo); // campo grupo formulario crear Empresa
                $('#empresa_clase').val(data.clase); // campo clase formulario crear Empresa
            });

        });
        
        // Retiro masivo, activacion seleccionar / deseleccionar todos
        $('#retiro_masivo').live('change', function() {  
            if ($(this).is(':checked'))
            {
                $('.retirar_empresa').prop('checked', true);
            }
            else 
            {
                $('.retirar_empresa').prop('checked', false);
            }
           
        });

        // Eliminar masivo seleccionar / deseleccionar todos
        $('#eliminar_masivo').live('change', function() {
            if ($(this).is(':checked'))
            {
                $('.eliminar_empresa').prop('checked', true);
            }
            else 
            {
                $('.eliminar_empresa').prop('checked', false);
            }  
            
        });

        $('.loader').hide();
        jQuery.ajaxSetup({
            
            beforeSend: function() { // muestra el GIF que indica se está cargando el AJAX
               $('.loader').show();
            },
            complete: function(){

                // Verificacion que valida el estado del checkbox seleccionar todos cuando se hace la paginación (AJAX) retirar empresa
                if (($('.retirar_empresa').size()) == ($(".retirar_empresa:checked").length))
                {
                    $('#retiro_masivo').prop('checked', true);
                }
                else
                {
                    $('#retiro_masivo').prop('checked', false);
                }
                $('.loader').hide(); // oculta el GIF que indica se está cargando el AJAX
            },
          success: function() {
            
          }
        });

        $('#activar_empresa').submit(function( event ) {
            

            if ($(".activar_empresa:checked").length == 0)
            {
                alert("Estimado usuario, no ha seleccionado ninguna empresa para ACTIVAR. Por favor verifique.");
                return false;
            }

        });

        // cuando  se hace submit del formulario se capturan los valores que tienen los combos de las empresas seleccionadas
       

        $('#formulario_retirar_empresa').submit(function( event ) { 
            
            // Se valida que se haya seleccionado alguna empresa para retirar
            if ($(".retirar_empresa:checked").length == 0)
            {
                alert("Estimado usuario, no ha seleccionado ninguna empresa para RETIRAR. Por favor verifique.");
                return false;
            }
            
            var seleccion_invalida;

            if ($('#retiro_masivo').is(':checked')) // retiro masivo
            {  

                if ($("#motivo_retiro").val() == 1)
                {
                    alert('Estimado usuario, la aplicación detectó que desea retirar empresas MASIVAMENTE. Por favor, verifique que ha seleccionado el MOTIVO DE RETIRO que se asignará masivamente.');
                    seleccion_invalida = true;
                    return false;
                }

                $('.retirar_empresa:checked').each(function() {
                    // Por cada empresa seleccionda se toma el valor de su id y el de los campos estatus y motivo retiro del control de retiro masivo
                    $('#datos_empresas_retirar').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#motivo_retiro").val()+ '">');
                });   
            }
            else // múltiple selecccion de empresas a retirar
            {
                
                $('.retirar_empresa:checked').each(function() {
                   

                    if ($("#"+$(this).val()+"motivo_ret").val() == 1)
                    {
                        alert('Debe seleccionar un Motivo Retiro para la empresa con prefijo ' + $(this).val());
                        seleccion_invalida = true;
                        return false;
                    }

                    // Por cada empresa seleccionda se toma el valor de su id y el de sus campos sub_estatus y motivo retiro
                    $('#datos_empresas_retirar').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#"+$(this).val()+"motivo_ret").val()+ '">');
                });
            }

            if (seleccion_invalida)
                return false;

           
            if (!confirm('¿ Estimado usuario, está seguro de RETIRAR la(s) empresa(s) seleccionada(s) ?'))
                return false;
        });

        // Formulario eliminar empresa y formulario retiradas son iguales

        $('#formulario_eliminar_empresa').submit(function( event ) { 


            // Se valida que se haya seleccionado alguna empresa para retirar
            if ($(".eliminar_empresa:checked").length == 0)
            {
                alert("Estimado usuario, no ha seleccionado ninguna empresa para ELIMINAR. Por favor verifique.");
                return false;
            }

            // $('.eliminar_empresa:checked').each(function() {
                    
            //     // Por cada empresa seleccionda se toma el valor de su id y el de los campos estatus y motivo retiro del control de retiro masivo
            //     $('#datos_empresas_eliminar').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#sub_estatus").val()+'_'+$("#motivo_retiro").val()+ '">');
            // });  
            
            //var seleccion_invalida;

            // if ($('#eliminar_masivo').is(':checked')) // Eliminacion masiva
            // {  
            //     // if ($("#sub_estatus").val() == 1)
            //     // {
            //     //     alert('Estimado usuario, la aplicación detectó que desea ELIMINAR empresas MASIVAMENTE. Por favor, verifique que ha seleccionado el SUB ESTATUS que se asignará masivamente.');
            //     //     seleccion_invalida = true;
            //     //     return false;
            //     // }

            //     // if ($("#motivo_retiro").val() == 1)
            //     // {
            //     //     alert('Estimado usuario, la aplicación detectó que desea ELIMINAR empresas MASIVAMENTE. Por favor, verifique que ha seleccionado el MOTIVO DE RETIRO que se asignará masivamente.');
            //     //     seleccion_invalida = true;
            //     //     return false;
            //     // }

                
            // }
            // else // múltiple selecccion de empresas a eliminar, no masivo
            // {

               
            //     $('.eliminar_empresa:checked').each(function() {

            //         if ($("#"+$(this).val()+"sub_estatus").val() == 1)
            //         {
            //             alert('Debe seleccionar un Sub Estatus para la empresa con prefijo ' + $(this).val());
            //             seleccion_invalida = true;
            //             return false;
            //         }

            //         if ($("#"+$(this).val()+"motivo_ret").val() == 1)
            //         {
            //             alert('Debe seleccionar un Motivo Retiro para la empresa con prefijo ' + $(this).val());
            //             seleccion_invalida = true;
            //             return false;
            //         }
                   
            //         // Por cada empresa seleccionda se toma el valor de su id y el de sus campos sub_estatus y motivo retiro
            //         $('#datos_empresas_eliminar').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#"+$(this).val()+"sub_estatus").val()+'_'+$("#"+$(this).val()+"motivo_ret").val()+ '">');
            //     });
            // }

            //  if (seleccion_invalida)
            //     return false;
            
            if (!confirm('¿ Estimado usuario, está seguro de ELIMINAR la(s) empresa(s) seleccionada(s) ?'))
                return false;
        });

        // $('#formulario_eliminadas').submit(function( event ) { 

        //     if ($(".reactivar_empresa:checked").length == 0)
        //     {
        //         alert("Estimado usuario, no ha seleccionado ninguna empresa para REACTIVAR. Por favor verifique.");
        //         return false;
        //     }

        // });

        
        // estilos de los botones exportar
        $('.etiqueta_regresar_empresas,.etiqueta_regresar_empresas_editar, .etiqueta_regresar_empresas_exportar, .regresar_empresas_sin_espacio, .regresar_empresas, .datos_contacto, .botones_menu, .exportar_empresas_no_validadas, .exportar_empresas_eliminadas, .exportar, .regresar, .retirar, .reactivar, .eliminar, .activar_empresa, .reactivar, .crear_empresa, .retirar_empresa_exportar, .empresas_retiradas_exportar').hover(
     
          function() { $(this).addClass('ui-state-hover'); },
          function() { $(this).removeClass('ui-state-hover');
        });

        // Se le da espacio a la parte superiori del datatable entre los botones y el datatatable
        $('.dataTables_wrapper').css('margin-top', '30px');

        // Botones  exportar del lisatdo general de Empresa
        $('body').on('click', '.exportar', function() {
           
            $('.parametros').html(
                '<input name="prefijo" type="hidden" value="'+$('tfoot tr th:nth-child(1) span input').val()+'">'+
                '<input name="nombre_empresa" type="hidden" value="'+$('tfoot tr th:nth-child(2) span input').val()+'">'+
                '<input name="fecha_activacion" type="hidden" value="'+$('tfoot tr th:nth-child(3) span input').val()+'">'+
                '<input name="ciudad" type="hidden" value="'+$('tfoot tr th:nth-child(4) span input').val()+'">'+
                '<input name="rif" type="hidden" value="'+$('tfoot tr th:nth-child(5) span input').val()+'">'+
                '<input name="sub_estatus" type="hidden" value="'+$('tfoot tr th:nth-child(7) span input').val()+'">'
                
            );

        });

        // Botones  exportar  al listado de retirar Empresa

        $('body').on('click', '.retirar_empresa_exportar', function() {
            
            $('.parametros').html(
                '<input name="prefijo" type="hidden" value="'+$('tfoot tr th:nth-child(2) span input').val()+'">'+
                '<input name="nombre_empresa" type="hidden" value="'+$('tfoot tr th:nth-child(3) span input').val()+'">'+
                '<input name="fecha_inscripcion" type="hidden" value="'+$('tfoot tr th:nth-child(4) span input').val()+'">'+
                '<input name="ciudad" type="hidden" value="'+$('tfoot tr th:nth-child(5) span input').val()+'">'+
                '<input name="rif" type="hidden" value="'+$('tfoot tr th:nth-child(6) span input').val()+'">'+
                '<input name="retirar" type="hidden" value="true">'
            );

        });

        // Botones  exportar  al listado empresas retiradas

        $('body').on('click', '.empresas_retiradas_exportar', function() {
            
            $('.parametros').html(
                '<input name="prefijo" type="hidden" value="'+$('tfoot tr th:nth-child(2) span input').val()+'">'+
                '<input name="nombre_empresa" type="hidden" value="'+$('tfoot tr th:nth-child(3) span input').val()+'">'+
                '<input name="fecha_inscripcion" type="hidden" value="'+$('tfoot tr th:nth-child(4) span input').val()+'">'+
                '<input name="ciudad" type="hidden" value="'+$('tfoot tr th:nth-child(5) span input').val()+'">'+
                '<input name="rif" type="hidden" value="'+$('tfoot tr th:nth-child(6) span input').val()+'">'+
                '<input name="fecha_retiro" type="hidden" value="'+$('tfoot tr th:nth-child(7) span input').val()+'">'+
                '<input name="subestatus" type="hidden" value="'+$('tfoot tr th:nth-child(12) span input').val()+'">'+
                '<input name="motivo_retiro" type="hidden" value="'+$('tfoot tr th:nth-child(13) span input').val()+'">'+
                '<input name="retiradas" type="hidden" value="true">'
            );

        });

        $('body').on('click', '.exportar_empresas_eliminadas', function() {
            
            $('.parametros').html(
                '<input name="prefijo" type="hidden" value="'+$('tfoot tr th:nth-child(1) span input').val()+'">'+
                '<input name="nombre_empresa" type="hidden" value="'+$('tfoot tr th:nth-child(2) span input').val()+'">'+
                '<input name="fecha_inscripcion" type="hidden" value="'+$('tfoot tr th:nth-child(3) span input').val()+'">'+
                '<input name="ciudad" type="hidden" value="'+$('tfoot tr th:nth-child(4) span input').val()+'">'+
                '<input name="rif" type="hidden" value="'+$('tfoot tr th:nth-child(5) span input').val()+'">'+
                '<input name="fecha_eliminacion" type="hidden" value="'+$('tfoot tr th:nth-child(6) span input').val()+'">'+
                '<input name="subestatus" type="hidden" value="'+$('tfoot tr th:nth-child(11) span input').val()+'">'+
                '<input name="motivo_retiro" type="hidden" value="'+$('tfoot tr th:nth-child(12) span input').val()+'">'+
                '<input name="eliminadas" type="hidden" value="true">'
            );

        });

        $('body').on('click', '.exportar_empresas_no_validadas', function() {
            
            $('.parametros').html(
                '<input name="prefijo" type="hidden" value="'+$('tfoot tr th:nth-child(2) span input').val()+'">'+
                '<input name="nombre_empresa" type="hidden" value="'+$('tfoot tr th:nth-child(3) span input').val()+'">'+
                '<input name="fecha_inscripcion" type="hidden" value="'+$('tfoot tr th:nth-child(4) span input').val()+'">'+
                '<input name="ciudad" type="hidden" value="'+$('tfoot tr th:nth-child(5) span input').val()+'">'+
                '<input name="rif" type="hidden" value="'+$('tfoot tr th:nth-child(6) span input').val()+'">'+
                '<input name="tipo_usuario" type="hidden" value="'+$('tfoot tr th:nth-child(8) span input').val()+'">'+
                '<input name="ventas_brutas" type="hidden" value="'+$('tfoot tr th:nth-child(9) span input').val()+'">'+
                '<input name="clasificacion" type="hidden" value="'+$('tfoot tr th:nth-child(10) span input').val()+'">'+
                '<input name="activacion" type="hidden" value="true">'
            );

        });

        function isValidEmailAddress(emailAddress) {
            var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
            return pattern.test(emailAddress);
        };

        function isValidNumberPhone(phoneNumber) {
            var pattern_phone_number = new RegExp(/^(\([0-9]{4}\) )[0-9]{3}-[0-9]{2}-[0-9]{2}$/);
            return pattern_phone_number.test(phoneNumber);
        };


        $('#formulario_crear_empresa').submit(function( event ) { 

            //valida formato email

            // if ($('#email.email').val() != '') 
            // {
            //     if( !isValidEmailAddress( $('#email').val() ) &&  (window.location.pathname.split('/')[2] == 'new') ) 
            //     { 
            //         alert('El formato en Correo Principal es inválido. Por favor verifique.');
            //         return false;
            //     }

            // }

            // if ($('#email1').val() != '') 
            // {
            //     if( !isValidEmailAddress( $('#email1').val() ) &&  (window.location.pathname.split('/')[2] == 'new') ) 
            //     { 
            //         alert('El formato en Correo Secundario es inválido. Por favor verifique.');
            //         return false;
            //     }

            // }



            // Validar el formato de los números de telefono (0212) 123-45-67

            // if ($('#codigo_telefono1').val() == '')
            // {
            //     alert('El código del Teléfono 1 NO puede estar en blanco. Por favor verifique.');
            //     return false;
            // }
            
            // if (($('#empresa_datos_contacto_attributes_0_contacto').val() == '')  &&  (window.location.pathname.split('/')[2] == 'new') ) // Validacion del primer número
            // {
            //     //if( !isValidNumberPhone($('#empresa_datos_contacto_attributes_0_contacto').val()))
            //     //{
            //         alert('El Teléfono 1 es obligatorio. Por favor verifique.');
            //         return false;
            //     //}

            // }

            // if (($('#telefono2').val() != '') && ($('#codigo_telefono2').val() == ''))
            // {
            //     alert('El código del Teléfono2 es obligatorio. Por favor verifique.');
            //     return false;
            // }

            // if (($('#telefono3').val() != '') && ($('#codigo_telefono3').val() == ''))
            // {
            //     alert('El código del Teléfono3 es obligatorio. Por favor verifique.');
            //     return false;
            // }

            // if (($('#fax').val() != '') && ($('#codigo_telefono4').val() == ''))
            // {
            //     alert('El código del FAX del fax. Por favor verifique.');
            //     return false;
            // }

            // if ($('#empresa_rif').val() == 'tipo')
            // {
            //     alert('Para el campo RIF, debe seleccionar un valor para el campo desplegable tipo de RIF');
            //     return false;
            // }




           
            // if (($('#telefono2').val() != '')   &&  (window.location.pathname.split('/')[2] == 'new') )// Validacion del segundo numero
            // {
            //     if( !isValidNumberPhone($('#telefono2').val()))
            //     {
            //         alert('El formato del Teléfono 2 es incorrecto. Por favor verifique.');
            //         return false;
            //     }

            // }

            // if (($('#telefono3').val() != '')   &&  (window.location.pathname.split('/')[2] == 'new') )// Validacion del segundo numero
            // {
            //     if( !isValidNumberPhone($('#telefono3').val()))
            //     {
            //         alert('El formato del Teléfono 3 es incorrecto. Por favor verifique.');
            //         return false;
            //     }

            // }

            // if (($('#fax').val() != '')  &&  (window.location.pathname.split('/')[2] == 'new') )// Validacion del segundo numero
            // {
            //     if( !isValidNumberPhone($('#fax').val()))
            //     {
            //         alert('El formato del Fax es incorrecto. Por favor verifique.');
            //         return false;
            //     }

            // }
        
        });

        // Se cambian todos los input a Mayusculas expceto login
        $('input').keyup(function() {
            
            if (($(this).attr('class') != 'login') && ($(this).attr('class') != 'email') && ($(this).attr('class') != 'clave'))
                this.value = this.value.toUpperCase();
        });

        $('#asignar_prefijo_manual').dialog({
          autoOpen: false,
          width: 900
         
        });


        // Botón para abrir el dialogo
        $('#boton_abrir_ventana_prefijo_manual').click(function(w){
          w.preventDefault(); // Deshabilita el hipervinculo el boton importar
          

          $('#prefijos_disponibles').dataTable({
            bDestroy: true,
            bJQueryUI: true
          });
          $('#asignar_prefijo_manual').dialog('open').attr('class', 'ventana_prefijo_manual');
          
        });

        //cierra la ventana para asignar prefijo manual
        $('#regresar_formulario_empresa').click(function(){
            $('.ventana_prefijo_manual').dialog('close');
            
        });

        // Accion del boton asignar prefijo en la ventana

        $('.boton_asignar_prefijo_manual').click(function(){

            if ($('#prefijo_manual').val() == '')
            {
                alert('Estimado usuario, no ha ingresado ningún PREFIJO para ser reutilizado');
            }
            else
            {
                $('#empresa_prefijo').val($('#prefijo_manual').val());
                $('#empresa_id_clasificacion').val($('#'+ $('#prefijo_manual').val()).val()).change();
                $('.ventana_prefijo_manual').dialog('close');
            }

            

        });


    })   

