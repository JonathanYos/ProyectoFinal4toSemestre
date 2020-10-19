<%-- 
    Document   : producto
    Created on : 5/10/2020, 05:30:22 PM
    Author     : jarno
--%>
<%@page import="modelo.InicioSesion"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.Marca"%>
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
            <p class="navbar-brand"> Menu</p>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-md-center" id="menu">

                <ul class="navbar-nav mr-auto">
                    <%
                        HttpSession s = request.getSession();
                        //Acceder a Session
                        if ((String) s.getAttribute("U") == null || (int) s.getAttribute("R") < 1) {
                            response.sendRedirect("InicioSesion.jsp");
                        } else {
                            InicioSesion login = new InicioSesion((String) s.getAttribute("U"), "");
                            DefaultTableModel tabla = new DefaultTableModel();
                            String rol = s.getAttribute("R").toString();
                            String rolEscrito;
                            switch (rol) {
                                case "1":
                                    rolEscrito = "Usted es admin";
                                    break;
                                case "2":
                                    rolEscrito = "Usted es empleado";
                                    break;
                                case "3":
                                    rolEscrito = "Usted es cliente";
                                    break;
                                default:
                                    rolEscrito = "Nos Hackeron XD";
                                    break;
                            }
                            String image = "<li class='nav-item dropdown' style='color:#fff; margin-top:5px;' >"
                                    + "<img src='" + login.LinkImage() + "' style='border-radius:50%;margin-right:5px;' width='30' height='30' alt=''>" + (String) s.getAttribute("U") + " (" + rolEscrito + ")</li>";
                            if (login.LinkImage().isEmpty()) {
                                image = "<li class='nav-item dropdown' style='color:#fff; margin-top:5px;'>"
                                        + "<img src='https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png' style='border-radius:50%; margin-right:5px;' width='30' height='30' alt=''>" + (String) s.getAttribute("U") + "</li>";
                            }

                            out.println(image);

                            tabla = login.GenerarMenu(rol);
                            for (int t = 0; t < tabla.getRowCount(); t++) {
                                if(s.getAttribute("R").toString().contains("3") && tabla.getValueAt(t, 1).toString().contains("Ventas"))
                                {
                                }
                                else{
                                String drop = "<li class='nav-item dropdown'>"
                                        + "<a class='nav-link dropdown-toggle' href='#' id='a" + tabla.getValueAt(t, 0) + "' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>"
                                        + tabla.getValueAt(t, 1) + "<a/>"
                                        + " <div class='dropdown-menu' aria-labelledby='a" + tabla.getValueAt(t, 1) + "'>"
                                        + "<a class='dropdown-item' href='" + tabla.getValueAt(t, 2) + "'>" + tabla.getValueAt(t, 1) + "</a>";
                                out.println(drop);

                                DefaultTableModel tabla2 = new DefaultTableModel();
                                tabla2 = login.GenerarSubMenu(tabla.getValueAt(t, 0).toString());
                                for (int y = 0; y < tabla2.getRowCount(); y++) {
                                    if (s.getAttribute("R").toString().contains("2") && tabla2.getValueAt(y, 1).toString().contains("Empleados")) {

                                    } else {
                                        if(s.getAttribute("R").toString().contains("3") && tabla2.getValueAt(y, 1).toString().contains("Marcas") || s.getAttribute("R").toString().contains("3") && tabla2.getValueAt(y, 1).toString().contains("Proveedores")){
                                        }else{
                                         String option = "<a class='dropdown-item' href='" + tabla2.getValueAt(y, 2) + "'>" + tabla2.getValueAt(y, 1)+"</a>";
                                        out.println(option);
                                        }
                                       
                                    }

                                }
                                out.println("</div></li>");
                            }}
                        }

                    %>
                    <li class='nav-item dropdown'>
                        <a class='nav-link' href='sr_cerrarSesion'>Cerrar Sesion</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div>

            <div class="modal fade" id="modal_producto" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Estudiante</h4>
                        </div>
                        <div class="modal-body">

                            <form class="form-group col-auto" action="sr_producto" method="post">
                                <div class="form-group col-auto">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_id">ID</label>
                                        </div>
                                        <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                                    </div>

                                    <div class="input-group">
                                        <div class="input-group-prepend">   
                                            <label class="input-group-text" for="lbl_producto">Producto</label>
                                        </div>
                                        <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Portatil" required>    
                                    </div>
                                    <br>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_marca">Marca</label>
                                        </div>
                                        <select class="form-control" name="drop_marca" id="drop_list" required>
                                            <%
                                                Marca marca = new Marca();
                                                HashMap<String, String> drop = marca.drop_sangre();
                                                for (String i : drop.keySet()) {
                                                    out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                                }
                                            %>
                                        </select>
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_descripcion">Descripcion</label>
                                        </div>
                                        <input type="text" name="txt_descripcion" id="txt_descripcion" class="form-control" placeholder="ej. Buena calidad" required> 
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_imagen">Imagen</label>
                                        </div>
                                        <input type="text" name="txt_imagen" id="txt_imagen" class="form-control" placeholder="ej. ruta imagen" required> 
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">    
                                            <label class="input-group-text" for="lbl_pcosto">Precio Costo</label>
                                        </div>
                                        <input type="text" name="txt_pcosto" id="txt_pcosto" class="form-control" placeholder="ej. 5.15" required> 
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_pventa">Precio Venta</label>
                                        </div>
                                        <input type="text" name="txt_pventa" id="txt_pventa" class="form-control" placeholder="ej. 6.50" required> 
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="lbl_existencia">Existencia</label>
                                        </div>
                                        <input type="text" name="txt_existencia" id="txt_existencia" class="form-control" placeholder="ej. 19" required>
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

            <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>           

            <table class="table table-hover table-dark">
                <thead>
                    <tr>
                        <th>Productos</th>
                        <th>Marcas</th>
                        <th>Descripcion</th>
                        <th>Imagen</th>
                        <th>Precio Costo</th>
                        <th>Precio Venta</th>
                        <th>Existencia</th>
                        <th>Fecha Ingreso</th>
                    </tr>
                </thead>
                <tbody id="tbl_productos">
                    <%
                        Producto producto = new Producto();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = producto.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
                            out.println("<tr data-id=" + tabla.getValueAt(t, 0) + " data-id_m=" + tabla.getValueAt(t, 2) + ">");
                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 9) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
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

                function limpiar() {
                    $("#txt_id").val(0);
                    $("#drop_list").val(1);
                    $("#txt_producto").val('');
                    $("#txt_descripcion").val('');
                    $("#txt_imagen").val('');
                    $("#txt_pcosto").val('');
                    $("#txt_pventa").val('');
                    $("#txt_existencia").val('');
                }

                $('#tbl_productos').on('click', 'tr td', function (evt) {
                    var target, id, id_m, producto, descripcion, imagen, p_costo, p_venta, existencia;

                    target = $(event.target);
                    id = target.parent().data('id');
                    id_m = target.parent().data('id_m');
                    producto = target.parents("tr").find("td").eq(0).html();
                    descripcion = target.parents("tr").find("td").eq(2).html();
                    imagen = target.parents("tr").find("td").eq(3).html();
                    p_costo = target.parents("tr").find("td").eq(4).html();
                    p_venta = target.parents("tr").find("td").eq(5).html();
                    existencia = target.parents("tr").find("td").eq(6).html();

                    $("#txt_id").val(id);
                    $("#txt_producto").val(producto);
                    $("#drop_list").val(id_m);
                    $("#txt_descripcion").val(descripcion);
                    $("#txt_imagen").val(imagen);
                    $("#txt_pcosto").val(p_costo);
                    $("#txt_pventa").val(p_venta);
                    $("#txt_existencia").val(existencia);
                    $("#modal_producto").modal('show');
                });
        </script>
        <style>
            body {
                background-color: beige;
            }
        </style>
    </body>
</html>
