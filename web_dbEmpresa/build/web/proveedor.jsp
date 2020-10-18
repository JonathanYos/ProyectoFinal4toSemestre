<%-- 
    Document   : proveedor
    Created on : 30/09/2020, 11:46:35 AM
    Author     : jarno
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Proveedor"%>
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
            <a class="nav-link" href="proveedor.jsp">PROVEEDOR<span class="sr-only">(current)</span></a>
          </li>
        </ul>
      </div>
    </nav>
        <div class="container">
<div class="modal fade" id="modal_proveedor" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Proveedor</h4>
        </div>
        <div class="modal-body">
            
            <form class="form-group col-auto" action="sr_proveedor" method="post">
            <div class="form-group col-auto">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_id">ID</label>
                    </div>
                    <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">    
                        <label class="input-group-text" for="lbl_proveedor">Provedor</label>
                    </div>
                    <input type="text" name="txt_proveedor" id="txt_proveedor" class="form-control" placeholder="ej. Carlos" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_nit">Nit</label>
                    </div>
                    <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="ej. 32145242-J" required> 
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
                
<button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_proveedor" onclick="limpiar()">Nuevo</button>           
                
<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>Proveedor</th>
        <th>Nit</th>
        <th>Direccion</th>
        <th>Telefono</th>
      </tr>
    </thead>
    <tbody id="tbl_proveedores">
        <% 
        Proveedor proveedor = new Proveedor();
        DefaultTableModel tabla = new DefaultTableModel();
        tabla = proveedor.leer();
        for (int t=0;t<tabla.getRowCount();t++){
            out.println("<tr data-id=" + tabla.getValueAt(t,0) + ">");
            out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,2) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,4) + "</td>");
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
       $("#txt_proveedor").val('');
       $("#txt_nit").val('');
       $("#txt_direccion").val('');
       $("#txt_telefono").val('');
    }   
        
   $('#tbl_proveedores').on('click','tr td', function(evt){
   var target,id,proveedor,nit,direccion,telefono;
   
   target = $(event.target);
   id = target.parent().data('id');
   proveedor= target.parents("tr").find("td").eq(0).html();
   nit= target.parents("tr").find("td").eq(1).html();
   direccion= target.parents("tr").find("td").eq(2).html();
   telefono= target.parents("tr").find("td").eq(3).html();
   
   $("#txt_id").val(id);
   $("#txt_proveedor").val(proveedor);
   $("#txt_nit").val(nit);
   $("#txt_direccion").val(direccion);
   $("#txt_telefono").val(telefono);
   $("#modal_proveedor").modal('show');
});
</script>
<style>
body {
  background-color: beige;
}
</style>
    </body>
</html>
