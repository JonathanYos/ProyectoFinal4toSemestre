/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jarno
 */
public class Producto {
    private int idproducto, idmarca, existencia;
    private String producto, descripcion,imagen,fecha_ingreso;
    private Float precio_costo, precio_venta;
    private Conexion cn;

    public Producto(){}

    public Producto(int idproducto, int idmarca, int existencia, String producto, String descripcion, String imagen, String fecha_ingreso, Float precio_costo, Float precio_venta) {
        this.idproducto = idproducto;
        this.idmarca = idmarca;
        this.existencia = existencia;
        this.producto = producto;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.fecha_ingreso = fecha_ingreso;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public int getIdmarca() {
        return idmarca;
    }

    public void setIdmarca(int idmarca) {
        this.idmarca = idmarca;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public Float getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(Float precio_costo) {
        this.precio_costo = precio_costo;
    }

    public Float getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(Float precio_venta) {
        this.precio_venta = precio_venta;
    }
    
    public HashMap drop_sangre(){
        HashMap<String, String> drop_producto = new HashMap();
        try{
            cn = new Conexion();
            String query = "select idproducto as idproducto, producto from productos;";
            cn.abrir_conexion();
            
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while(consulta.next()){
                drop_producto.put(consulta.getString("idproducto"), consulta.getString("producto"));
            }
            cn.cerrar_conexion();
            
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        
        return drop_producto;
    } 
    
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     cn = new Conexion();
     cn.abrir_conexion();
      String query = "SELECT p.idproducto as id,p.producto,m.idmarca,p.descripcion,p.imagen,p.precio_costo,p.precio_venta,p.existencia,p.fecha_ingreso,m.marca FROM productos as p inner join marcas as m on p.idmarca = m.idmarca;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","producto","idmarca","descripcion","imagen","precio_costo","precio_venta","existencia","fecha_ingreso","marca"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[10];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("producto");
          datos[2] = consulta.getString("idmarca");
          datos[3] = consulta.getString("descripcion");
          datos[4] = consulta.getString("imagen");
          datos[5] = consulta.getString("precio_costo");
          datos[6] = consulta.getString("precio_venta");
          datos[7] = consulta.getString("existencia");
          datos[8] = consulta.getString("fecha_ingreso");
          datos[9] = consulta.getString("marca");
          tabla.addRow(datos);
      
      }
      
     cn.cerrar_conexion();
 }catch(SQLException ex){
     System.out.println(ex.getMessage());
 }
 return tabla;
 }
    
    public int agregar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO productos (producto, idmarca, descripcion, imagen, precio_costo, precio_venta, existencia) VALUES (?,?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1, this.getProducto());
            parametro.setInt(2, this.getIdmarca());
            parametro.setString(3, this.getDescripcion());
            parametro.setString(4, this.getImagen());
            parametro.setFloat(5, this.getPrecio_costo());
            parametro.setFloat(6, this.getPrecio_venta());
            parametro.setInt(7, this.getExistencia());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
    

    public int modificar (){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE productos SET producto = ?, idmarca = ?, descripcion = ?, imagen = ?, precio_costo = ?, precio_venta = ?, existencia = ? WHERE idproducto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1, this.getProducto());
            parametro.setInt(2, this.getIdmarca());
            parametro.setString(3, this.getDescripcion());
            parametro.setString(4, this.getImagen());
            parametro.setFloat(5, this.getPrecio_costo());
            parametro.setFloat(6, this.getPrecio_venta());
            parametro.setInt(7, this.getExistencia());
            parametro.setInt(8, this.getIdproducto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
    
    public int eliminar (){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "delete from productos  where idproducto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdproducto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
