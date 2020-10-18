/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jarno
 */
public class Compra_Detalle {
    public int idcompradetalle,idcompra,idproducto,cantidad;
    public float precio_costo_unitario;
    private Conexion cn;

    public Compra_Detalle(){}
    public Compra_Detalle(int idcompradetalle, int idcompra, int idproducto, int cantidad, float precio_costo_unitario) {
        this.idcompradetalle = idcompradetalle;
        this.idcompra = idcompra;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    public int getIdcompradetalle() {
        return idcompradetalle;
    }

    public void setIdcompradetalle(int idcompradetalle) {
        this.idcompradetalle = idcompradetalle;
    }

    public int getIdcompra() {
        return idcompra;
    }

    public void setIdcompra(int idcompra) {
        this.idcompra = idcompra;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public float getPrecio_costo_unitario() {
        return precio_costo_unitario;
    }

    public void setPrecio_costo_unitario(float precio_costo_unitario) {
        this.precio_costo_unitario = precio_costo_unitario;
    }
   
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     cn = new Conexion();
     cn.abrir_conexion();
      String query = "SELECT d.idcompra_detalle as id,c.idcompra,p.idproducto,d.cantidad,d.precio_costo_unitario,c.no_orden_compra,e.idProveedor,c.fecha_orden,c.fecha_ingreso,p.producto,e.proveedor FROM compras_detalle as d inner join compras as c on d.idcompra = c.idcompra inner join productos as p on d.idproducto = p.idproducto inner join proveedores as e on c.idProveedor = e.idProveedor;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","idcompra","idproducto","cantidad","precio_costo_unitario","no_orden_compra","idProveedor","fecha_orden","fecha_ingreso","producto","proveedor"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[11];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("idcompra");
          datos[2] = consulta.getString("idproducto");
          datos[3] = consulta.getString("cantidad");
          datos[4] = consulta.getString("precio_costo_unitario");
          datos[5] = consulta.getString("no_orden_compra");
          datos[6] = consulta.getString("idProveedor");
          datos[7] = consulta.getString("fecha_orden");
          datos[8] = consulta.getString("fecha_ingreso");
          datos[9] = consulta.getString("producto");
          datos[10] = consulta.getString("proveedor");
          tabla.addRow(datos);
      
      }
      
     cn.cerrar_conexion();
 }catch(SQLException ex){
     System.out.println(ex.getMessage());
 }
 return tabla;
 }

    public int agregar(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO compras_detalle (idcompra, idproducto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdcompra());
            parametro.setInt(2, this.getIdproducto());
            parametro.setInt(3, this.getCantidad());
            parametro.setFloat(4, this.getPrecio_costo_unitario());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
    
    public int modificar(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE compras_detalle SET idcompra = ?, idproducto = ?, cantidad = ?, precio_costo_unitario = ? WHERE idcompra_detalle = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdcompra());
            parametro.setInt(2, this.getIdproducto());
            parametro.setInt(3, this.getCantidad());
            parametro.setFloat(4, this.getPrecio_costo_unitario());
            parametro.setInt(5, this.getIdcompradetalle());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
    
    public int eliminar(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM compraa_detalle WHERE idcompra_detalle = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdcompradetalle());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
