/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Producto;

/**
 *
 * @author jarno
 */
@MultipartConfig
public class sr_producto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Producto producto;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_producto</title>");            
            out.println("</head>");
            out.println("<body>");
           producto = new Producto(Integer.valueOf(request.getParameter("txt_id")), Integer.valueOf(request.getParameter("drop_marca")), Integer.valueOf(request.getParameter("txt_existencia")), request.getParameter("txt_producto"), request.getParameter("txt_descripcion"), request.getParameter("nombreimagen"), request.getParameter("txt_fecha_ingreso"), Float.valueOf(request.getParameter("txt_pcosto")), Float.valueOf(request.getParameter("txt_pventa")));             
            if("Agregar".equals(request.getParameter("btn_agregar"))){
                if(producto.agregar() > 0){
                       Part archivo = request.getPart("txt_imagen");
                    InputStream p = archivo.getInputStream();
                    File file = new File("C:\\Users\\JonathanY\\Desktop\\Final Jsp\\web_dbEmpresa\\web\\img\\"+request.getParameter("nombreimagen"));
                    FileOutputStream o = new FileOutputStream(file);
                    
                    int data = p.read();
                    while (data != -1) {
                        o.write(data);
                        data = p.read();
                    }
                    o.close();
                    p.close();
                    response.sendRedirect("producto.jsp");
                }else{
                    out.println("<h1>Error al ingresar</h1>");
                    out.println("<a href='producto.jsp'>Regresar</a>");
                }
            }
            
            if("Modificar".equals(request.getParameter("btn_modificar"))){
                   Part archivo = request.getPart("txt_imagen");
                    InputStream p = archivo.getInputStream();
                    File file = new File("C:\\Users\\JonathanY\\Desktop\\Final Jsp\\web_dbEmpresa\\web\\img\\"+request.getParameter("nombreimagen"));
                    FileOutputStream o = new FileOutputStream(file);
                    
                    int data = p.read();
                    while (data != -1) {
                        o.write(data);
                        data = p.read();
                    }
                    o.close();
                    p.close();
                if(producto.modificar() > 0){
                     
                    response.sendRedirect("producto.jsp");
                }else{
                    out.println("<h1>Error al modificar</h1>");
                    out.println("<a href='producto.jsp'>Regresar</a>");
                }
            }
                        
            if("Eliminar".equals(request.getParameter("btn_eliminar"))){
                if(producto.eliminar() > 0){
                    response.sendRedirect("producto.jsp");
                }else{
                    out.println("<h1>Error al eliminar</h1>");
                    out.println("<a href='producto.jsp'>Regresar</a>");
                }
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
