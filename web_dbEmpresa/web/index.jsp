<%-- 
    Document   : index
    Created on : 27/09/2020, 11:47:00 AM
    Author     : jarno
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.InicioSesion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
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
                            InicioSesion login = new InicioSesion();
                            DefaultTableModel tabla = new DefaultTableModel();
                            String rol = s.getAttribute("R").toString();
                            tabla = login.GenerarMenu(rol);
                            for (int t = 0; t < tabla.getRowCount(); t++) {
                                String drop = "<li class='nav-item dropdown'>"
                                        + "<a class='nav-link dropdown-toggle' href='#' id='a" + tabla.getValueAt(t, 0) + "' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>"
                                        + tabla.getValueAt(t, 1) + "<a/>"
                                        + " <div class='dropdown-menu' aria-labelledby='a" + tabla.getValueAt(t, 1) + "'>"
                                        + "<a class='dropdown-item' href='" + tabla.getValueAt(t, 2) + "'>" + tabla.getValueAt(t, 1) + "</a>";
                                out.println(drop);

                                DefaultTableModel tabla2 = new DefaultTableModel();
                                tabla2 = login.GenerarSubMenu(tabla.getValueAt(t, 0).toString());
                                for (int y = 0; y < tabla2.getRowCount(); y++) {
                                    String option = "<a class='dropdown-item' href='" + tabla2.getValueAt(y, 2) + "'>" + tabla2.getValueAt(y, 1) + "</a>";
                                    out.println(option);
                                }
                                out.println("</div></li>");
                            }
                        }

                    %>
                </ul>
            </div>
        </nav>
        <table>
            <tr>

            </tr>
        </table>
    </body>
</html>