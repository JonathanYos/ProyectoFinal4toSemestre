<%-- 
    Document   : cliente
    Created on : 30/09/2020, 10:51:39 AM
    Author     : jarno
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Cliente"%>
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
            <a class="nav-link" href="cliente.jsp">CLIENTE<span class="sr-only">(current)</span></a>
          </li>
        </ul>
      </div>
    </nav>
        <div class="container">
<div class="modal fade" id="modal_cliente" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Cliente</h4>
        </div>
        <div class="modal-body">
            
            <form class="form-group col-auto" action="sr_cliente" method="post">
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
                        <label class="input-group-text" for="lbl_nit">Nit</label>
                    </div>
                    <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="ej. 1234-a" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_genero">Género</label>
                    </div>
                    <input type="text" name="txt_genero" id="txt_genero" class="form-control" placeholder="ej. H = 1, F =0" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_telefono">Telefono</label>
                    </div>
                    <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="ej. 12345678" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_correo_electronico">Correo electronico </label>
                    </div>
                    <input type="tst" name="txt_correo_electronico" id="txt_correo_electronico" class="form-control" placeholder="ej. equipo_business@gmail.com" required>
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
                
<button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_cliente" onclick="limpiar()">Nuevo</button>           
                
<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>Nombres</th>
        <th>Apellidos</th>
        <th>Nit</th>
        <th>Género</th>
        <th>Telefono</th>
        <th>Correo electronico</th>
        <th>fecha Ingreso</th>
      </tr>
    </thead>
    <tbody id="tbl_empleados">
        <% 
        Cliente cliente = new Cliente();
        DefaultTableModel tabla = new DefaultTableModel();
        tabla = cliente.leer();
        for (int t=0;t<tabla.getRowCount();t++){
            out.println("<tr data-id=" + tabla.getValueAt(t,0) + ">");
            out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,2) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,4) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,5) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,6) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,7) + "</td>");
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
       $("#txt_nit").val('');
       $("#txt_genero").val('');
       $("#txt_telefono").val('');
       $("#txt_correo_electronico").val('');
       $("#txt_fecha_ingreso").val('');
    }   
        
   $('#tbl_empleados').on('click','tr td', function(evt){
   var target,id,id_ts,nombres,apellidos,nit,telefono,genero,correo,ingreso;
   
   target = $(event.target);
   id = target.parent().data('id');
   nombres= target.parents("tr").find("td").eq(0).html();
   apellidos= target.parents("tr").find("td").eq(1).html();
   nit= target.parents("tr").find("td").eq(2).html();
   genero= target.parents("tr").find("td").eq(3).html(); 
   telefono= target.parents("tr").find("td").eq(4).html();
   correo= target.parents("tr").find("td").eq(5).html();
   ingreso= target.parents("tr").find("td").eq(6).html();
   
   $("#txt_id").val(id);
   $("#txt_nombres").val(nombres);
   $("#txt_apellidos").val(apellidos);
   $("#txt_nit").val(nit);
   $("#txt_genero").val(genero);
   $("#txt_telefono").val(telefono);
   $("#txt_correo_electronico").val(correo);
   $("#txt_fecha_ingreso").val(ingreso);
   $("#modal_cliente").modal('show');
});
</script>
<style>
body {
  background-color: beige;
}
</style>
    </body>
</html>
