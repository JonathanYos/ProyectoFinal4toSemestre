<%-- 
    Document   : empleado
    Created on : 27/09/2020, 02:01:56 PM
    Author     : jarno
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Empleado"%>
<%@page import="modelo.Puesto"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="collapse navbar-collapse justify-content-md-center">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="index.jsp">MENÚ</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="puesto.jsp">PUESTO<span class="sr-only">(current)</span></a>
          </li>
        </ul>
      </div>
    </nav>
        <div class="container">
<div class="modal fade" id="modal_empleado" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Empleado</h4>
        </div>
        <div class="modal-body">
            
            <form class="form-group col-auto" action="sr_empleado" method="post">
            <div class="form-group col-auto">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_id">ID</label>
                    </div>
                    <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">    
                        <label class="input-group-text" for="lbl_nombres">Nombres</label>
                    </div>
                    <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="ej. Jarod" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_apellidos">Apellidos</label>
                    </div>
                    <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="ej. Mejía" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">    
                        <label class="input-group-text" for="lbl_direccion">Direccion</label>
                    </div>
                    <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="ej. San Lucas" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_telefono">Telefono</label>
                    </div>
                    <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="ej. 12345678" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_dpi">DPI</label>
                    </div>
                    <input type="text" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="ej. 1234567890" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_genero">Género</label>
                    </div>
                    <input type="text" name="txt_genero" id="txt_genero" class="form-control" placeholder="ej. H = 1, F =0" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_fecha_nacimiento">Fecha nacimiento</label>
                    </div>
                    <input type="date" name="txt_fecha_nacimiento" id="txt_fecha_nacimiento" class="form-control" placeholder="ej. 1999-03-21" required>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_puesto">Puesto</label>
                    </div>
                <select class="form-control" name="drop_puesto" id="drop_list" required>
                    <% 
                        Puesto puesto = new Puesto();
                        HashMap<String, String> drop = puesto.drop_sangre();
                        for(String i: drop.keySet()){
                            out.println("<option value='" + i + "'>" + drop.get(i) +"</option>");
                        }
                    %>
                </select>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_fecha_inicio_labores">Inicio Labores</label>
                    </div>
                    <input type="date" name="txt_fecha_inicio_labores" id="txt_fecha_inicio_labores" class="form-control" placeholder="ej. 1999-03-21" required>
                </div>

                <input type="submit" class="btn btn-primary" name="btn_agregar" id="btn_agregar" value="Agregar" >
                <input type="submit" class="btn btn-success" name="btn_modificar" id="btn_modificar"  value="Modificar">
                <input type="submit" class="btn btn-danger" name="btn_eliminar" id="btn_modificar" value="Eliminar">
                <input type="submit" class="btn btn-info" data-dismiss="modal" value="Cerrar">
            </div>
            </form>
                
        </div>
      </div>
      
    </div>
  </div>
                
<button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_empleado" onclick="limpiar()">Nuevo</button>           
                
<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>Nombres</th>
        <th>Apellidos</th>
        <th>Direccion</th>
        <th>Telefono</th>
        <th>DPI</th>
        <th>Género</th>
        <th>Nacimiento</th>
        <th>Puesto</th>
        <th>Inicio Labores</th>
        <th>Ingreso</th>
      </tr>
    </thead>
    <tbody id="tbl_empleados">
        <% 
        Empleado empleado = new Empleado();
        DefaultTableModel tabla = new DefaultTableModel();
        tabla = empleado.leer();
        for (int t=0;t<tabla.getRowCount();t++){
            out.println("<tr data-id=" + tabla.getValueAt(t,0) + " data-id_ts=" + tabla.getValueAt(t,9) + ">");
            out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,2) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,4) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,5) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,6) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,7) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,8) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,10) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,11) + "</td>");
            out.println("</tr>");
        }
        %>
      
    </tbody>
  </table>
        </div>
        
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script>
function limpiar(){
        $("#txt_id").val(0);
       $("#txt_nombres").val('');
       $("#txt_apellidos").val('');
       $("#txt_direccion").val('');
       $("#txt_telefono").val('');
       $("#txt_dpi").val('');
       $("#txt_genero").val('');
       $("#txt_fecha_nacimiento").val('');
       $("#drop_list").val(1);
       $("#txt_fecha_inicio_labores").val('');
    }   
        
   $('#tbl_empleados').on('click','tr td', function(evt){
   var target,id,id_ts,nombres,apellidos,direccion,telefono,dpi,genero,nacimiento,labores;
   
   target = $(event.target);
   id = target.parent().data('id');
   id_ts = target.parent().data('id_ts');
   nombres= target.parents("tr").find("td").eq(0).html();
   apellidos= target.parents("tr").find("td").eq(1).html();
   direccion= target.parents("tr").find("td").eq(2).html();
   telefono= target.parents("tr").find("td").eq(3).html();
   dpi= target.parents("tr").find("td").eq(4).html();
   genero= target.parents("tr").find("td").eq(5).html(); 
   nacimiento= target.parents("tr").find("td").eq(6).html();
   labores= target.parents("tr").find("td").eq(8).html();
   
   $("#txt_id").val(id);
   $("#txt_nombres").val(nombres);
   $("#txt_apellidos").val(apellidos);
   $("#txt_direccion").val(direccion);
   $("#txt_telefono").val(telefono);
   $("#txt_dpi").val(dpi);
   $("#txt_genero").val(genero);
   $("#drop_list").val(id_ts); 
   $("#txt_fecha_nacimiento").val(nacimiento);
   $("#txt_fecha_inicio_labores").val(labores);
   $("#modal_empleado").modal('show');
});
</script>
<style>
body {
  background-color: beige;
}
</style>
    </body>
</html>
