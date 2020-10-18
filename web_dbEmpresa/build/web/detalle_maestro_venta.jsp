<%-- 
    Document   : detalle_maestro_venta
    Created on : 11/10/2020, 01:26:53 PM
    Author     : jarno
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Venta"%>
<%@page import="modelo.Venta_Detalle"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Empleado"%>
<%@page import="modelo.Producto"%>
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
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">MENU</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="detalle_maestro_venta.jsp">VENTAS<span class="sr-only">(current)</span></a>
          </li>
        </ul>
      </div>
    </nav>
        <div>
            
<div class="modal fade" id="modal_dmaestro" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Detalle Maestro</h4>
        </div>
        <div class="modal-body">
            
            <form class="form-group col-auto" action="sr_venta" method="post">
            <div class="form-group col-auto">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_id_venta">ID</label>
                    </div>
                    <input type="text" name="txt_id_venta" id="txt_id_venta" class="form-control" value="0" readonly>
                </div>
                
                <div class="input-group">
                    <div class="input-group-prepend">   
                        <label class="input-group-text" for="lbl_no_factura">No. Factura</label>
                    </div>
                    <input type="text" name="txt_no_factura" id="txt_no_factura" class="form-control" placeholder="ej. 1123" required>    
                </div>
                
                <div class="input-group">
                    <div class="input-group-prepend">   
                        <label class="input-group-text" for="lbl_serie">Serie</label>
                    </div>
                    <input type="text" name="txt_serie" id="txt_serie" class="form-control" placeholder="ej. A" required>    
                </div>
                
                <div class="input-group">
                    <div class="input-group-prepend">   
                        <label class="input-group-text" for="lbl_fecha_factura">Fecha Factura</label>
                    </div>
                    <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" placeholder="ej. 1123" required>    
                </div>
                <br>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_cliente">Cliente</label>
                    </div>
                <select class="form-control" name="drop_cliente" id="drop_listc" required>
                    <% 
                        Cliente clliente = new Cliente();
                        HashMap<String, String> drop = clliente.drop_sangre();
                        for(String i: drop.keySet()){
                            out.println("<option value='" + i + "'>" + drop.get(i) +"</option>");
                        }
                    %>
                </select>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_empleado">Empleado</label>
                    </div>
                <select class="form-control" name="drop_empleado" id="drop_liste" required>
                    <% 
                        Empleado empleado = new Empleado();
                        HashMap<String, String> drop_empleado = empleado.drop_sangre();
                        for(String i: drop_empleado.keySet()){
                            out.println("<option value='" + i + "'>" + drop_empleado.get(i) +"</option>");
                        }
                    %>
                </select>
                </div>

                <input type="submit" class="btn btn-primary" name="btn_agregar" id="btn_agregar" value="Agregar" >
                <input type="submit" class="btn btn-success" name="btn_modificar" id="btn_modificar"  value="Modificar">
                <input type="submit" class="btn btn-danger" name="btn_eliminar" id="btn_modificar" value="Eliminar">
                <input type="submit" class="btn btn-info" data-dismiss="modal" value="Cerrar">
            </div>
            </form>
                
            <form class="form-group col-auto" action="sr_detalle_venta" method="post">
            <div class="form-group col-auto">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_id_vdetalle">ID</label>
                    </div>
                    <input type="text" name="txt_id_vdetalle" id="txt_id_vdetalle" class="form-control" value="0" readonly>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_venta">Venta</label>
                    </div>
                <select class="form-control" name="drop_venta" id="drop_listv" required>
                    <% 
                        Venta venta = new Venta();
                        HashMap<String, String> drop_venta = venta.drop_sangre();
                        for(String i: drop_venta.keySet()){
                            out.println("<option value='" + i + "'>" + drop_venta.get(i) +"</option>");
                        }
                    %>
                </select>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_producto">Producto</label>
                    </div>
                <select class="form-control" name="drop_producto" id="drop_listp" required>
                    <% 
                        Producto producto = new Producto();
                        HashMap<String, String> drop_producto = producto.drop_sangre();
                        for(String i: drop_producto.keySet()){
                            out.println("<option value='" + i + "'>" + drop_producto.get(i) +"</option>");
                        }
                    %>
                </select>
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_cantidad">Cantidad</label>
                    </div>
                    <input type="text" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="ej. 12" required> 
                </div>
                
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="lbl_precio_unitario">Precio unitario</label>
                    </div>
                    <input type="text" name="txt_precio_unitario" id="txt_precio_unitario" class="form-control" placeholder="ej. 1250.99" required> 
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
                
<button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_dmaestro" onclick="limpiar()">Nuevo</button>           
               
<!--<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>No. Orden</th>
        <th>Proveedor</th>
        <th>Fecha Orden</th>
        <th>Fecha Ingreso</th>
      </tr>
    </thead>
    <tbody id="tbl_comras">
        <% 
        /*Compra compras = new Compra();
        DefaultTableModel tabla = new DefaultTableModel();
        tabla = compras.leer();
        for (int t=0;t<tabla.getRowCount();t++){
            out.println("<tr data-id=" + tabla.getValueAt(t,0) + " data-id_m=" + tabla.getValueAt(t,2) + ">");
            out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,5) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
            out.println("<td>" + tabla.getValueAt(t,4) + "</td>");

            out.println("</tr>");
        }*/
        %>
      
    </tbody>
  </table>
        
<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>Compra</th>
        <th>Producto</th>
        <th>Cantidad</th>
        <th>Precio Unitario</th>
      </tr>
    </thead>
    <tbody id="tbl_cdetalle">
        <% 
       /* Compra_Detalle cdetalle = new Compra_Detalle();
        DefaultTableModel tablas = new DefaultTableModel();
        tablas = cdetalle.leer();
        for (int t=0;t<tablas.getRowCount();t++){
            out.println("<tr data-id=" + tablas.getValueAt(t,0) + " data-id_c=" + tablas.getValueAt(t,1)  + " data-id_p=" + tablas.getValueAt(t,2) +">");
            out.println("<td>" + tablas.getValueAt(t,5) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,6) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,3) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,4) + "</td>");

            out.println("</tr>");
        }*/
        %>
      
    </tbody>
  </table>--->

<table class="table table-hover table-dark">
    <thead>
      <tr>
        <th>No. Factura</th>
        <th>Producto</th>
        <th>Cantidad</th>
        <th>Precio Unitario</th>
        <th>Serie</th>
        <th>Fecha Factura</th>
        <th>Cliente</th>
        <th>Empleado</th>
        <th>Fecha Ingreso</th>
      </tr>
    </thead>
    <tbody id="tbl_cdetalle">
        <% 
        Venta_Detalle vdetalle = new Venta_Detalle();
        DefaultTableModel tablas = new DefaultTableModel();
        tablas = vdetalle.leer();
        for (int t=0;t<tablas.getRowCount();t++){
            out.println("<tr data-id_vd=" + tablas.getValueAt(t,0) + " data-id_v=" + tablas.getValueAt(t,1)  + " data-id_p=" + tablas.getValueAt(t,2) + " data-id_c=" + tablas.getValueAt(t,9) + " data-id_e=" + tablas.getValueAt(t,10) +">");
            out.println("<td>" + tablas.getValueAt(t,6) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,5) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,3) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,4) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,7) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,8) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,12) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,13) + "</td>");
            out.println("<td>" + tablas.getValueAt(t,11) + "</td>");

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
       $("#txt_id_venta").val(0);
       $("#txt_id_vdetalle").val(0);
       $("#drop_listc").val(1);
       $("#drop_liste").val(1);
       $("#drop_listv").val(1);
       $("#drop_listp").val(1);
       $("#txt_no_factura").val('');
       $("#txt_serie").val('');
       $("#txt_fecha_factura").val('');
       $("#txt_cantidad").val('');
       $("#txt_precio_unitario").val('');
    }   
        /*
 $('#tbl_comras').on('click','tr td', function(evt){
   var target,id,id_m,no_orden,fecha_orden;
   
   target = $(event.target);
   id = target.parent().data('id');
   id_m = target.parent().data('id_m');
   no_orden= target.parents("tr").find("td").eq(0).html();
   fecha_orden= target.parents("tr").find("td").eq(2).html();
   
   $("#txt_id_compra").val(id);
   $("#txt_no_orden_compra").val(no_orden);
   $("#drop_list").val(id_m);
   $("#txt_fecha_orden").val(fecha_orden);
   $("#modal_dmaestro").modal('show');
});

 $('#tbl_cdetalle').on('click','tr td', function(evt){
   var target,id,id_c,id_p,cantidad,p_c_u;
   
   target = $(event.target);
   id = target.parent().data('id');
   id_c = target.parent().data('id_c');
   id_p = target.parent().data('id_p');
   cantidad= target.parents("tr").find("td").eq(2).html();
   p_c_u= target.parents("tr").find("td").eq(3).html();
   
   $("#txt_id_cdetalle").val(id);
   $("#drop_listc").val(id_c);
   $("#drop_listp").val(id_p);
   $("#txt_cantidad").val(cantidad);
   $("#txt_precio_costo_unitario").val(p_c_u);
   $("#modal_dmaestro").modal('show');
});
*/
 $('#tbl_cdetalle').on('click','tr td', function(evt){
   var target,id_c,id_e,id_vd,id_v,id_p,no_factura,serie,fecha_factura,cantidad,precio_unitario;
   
   target = $(event.target);
   id_c = target.parent().data('id_c');
   id_e = target.parent().data('id_e');
   id_vd = target.parent().data('id_vd');
   id_v = target.parent().data('id_v');
   id_p = target.parent().data('id_p');
   no_factura = target.parents("tr").find("td").eq(0).html();
   serie = target.parents("tr").find("td").eq(4).html();
   fecha_factura = target.parents("tr").find("td").eq(5).html();
   cantidad = target.parents("tr").find("td").eq(2).html();
   precio_unitario = target.parents("tr").find("td").eq(3).html();
   
   $("#txt_id_venta").val(id_v);
   $("#txt_no_factura").val(no_factura);
   $("#txt_serie").val(serie);
   $("#txt_fecha_factura").val(fecha_factura);
   $("#drop_listc").val(id_c);
   $("#drop_liste").val(id_e);
   
   $("#txt_id_vdetalle").val(id_vd);
   $("#drop_listv").val(id_v);
   $("#drop_listp").val(id_p);
   $("#txt_cantidad").val(cantidad);
   $("#txt_precio_unitario").val(precio_unitario);
   $("#modal_dmaestro").modal('show');
});
</script>
<style>
body {
  background-color: beige;
}
</style>
    </body>
</html>
