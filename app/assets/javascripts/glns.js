$( document ).ready(function() {

        // Datatable que maneja el listado de glns
        $("#data_table_glns").dataTable({
            sPaginationType: "full_numbers",
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',            
            sAjaxSource: $('#data_table_glns').data('source')
        }).columnFilter({ aoColumns: [{ type: "text"},{ type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}]});


        // Datatable que maneja el listado de glns
        $("#data_table_eliminar_gln").dataTable({
            sPaginationType: "full_numbers",
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',            
            sAjaxSource: $('#data_table_eliminar_gln').data('source')
        }).columnFilter({ aoColumns: [null,{ type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}]});

         // Datatable que maneja el listado de glns
        $("#data_table_gln_eliminado").dataTable({
            sPaginationType: "full_numbers",
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sDom: 'T<"clear">lfrtip',            
            sAjaxSource: $('#data_table_gln_eliminado').data('source')
        }).columnFilter({ aoColumns: [{ type: "text"}, {type: "text" }, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}, {type: "text"}]});


        // Efectos del boton importar
        $('.eliminar_gln').hover(
          function() { $(this).addClass('ui-state-hover'); },
          function() { $(this).removeClass('ui-state-hover');}
        );

      
        // ELiminar masivo seleccionar / deseleccionar todos
        $('#eliminar_masivo_gln').live('change', function() {
            
            if ($(this).is(':checked'))
            {
                $('.eliminar_gln').prop('checked', true);
            }
            else 
            {
                $('.eliminar_gln').prop('checked', false);
            }  
            
        });

        // Formulario eliminar GLN

        $('#formulario_eliminar_gln').submit(function( event ) { 
            
            // Se valida que se haya seleccionado alguna empresa para retirar
            if ($(".eliminar_gln:checked").length == 0)
            {
                alert("Estimado usuario, no ha seleccionado ningún GLN para ELIMINAR. Por favor verifique.");
                return false;
            }

            if ($('#eliminar_masivo_').is(':checked')) // elimino masivo
            {  
                $('.eliminar_gln:checked').each(function() {
                    // Por cada producto seleccionado se toma el valor de su id y el de los campos estatus y motivo retiro del control de retiro masivo
                    $('#datos_productos_eliminar_productos').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#sub_estatus").val()+'_'+$("#motivo_retiro").val()+ '">');
                });   
            }
            else 
            {
                $('.eliminar_gln:checked').each(function() {
                    // Por cada producto selecciondo se toma el valor de su id y el de sus campos sub_estatus y motivo retiro
                    $('#datos_eliminar_gln').append('<input type="hidden" name="'+$(this).val()+'" value="'+$(this).val()+'_'+$("#"+$(this).val()+"sub_estatus").val()+'_'+$("#"+$(this).val()+"motivo_ret").val()+ '">');
                });
            }
        });

});