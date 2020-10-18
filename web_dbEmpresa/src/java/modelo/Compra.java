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
public class Compra {
    public int idcompra,no_orden_compra,idproveedor;
    public String fecha_compra,fecha_ingreso;
    private Conexion cn;

    public Compra(){}
    public Compra(int idcompra, int no_orden_compra, int idproveedor, String fecha_compra, String fecha_ingreso) {
        this.idcompra = idcompra;
        this.no_orden_compra = no_orden_compra;
        this.idproveedor = idproveedor;
        this.fecha_compra = fecha_compra;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getIdcompra() {
        return idcompra;
    }

    public void setIdcompra(int idcompra) {
        this.idcompra = idcompra;
    }

    public int getNo_orden_compra() {
        return no_orden_compra;
    }

    public void setNo_orden_compra(int no_orden_compra) {
        this.no_orden_compra = no_orden_compra;
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
        this.idproveedor = idproveedor;
    }

    public String getFecha_compra() {
        return fecha_compra;
    }

    public void setFecha_compra(String fecha_compra) {
        this.fecha_compra = fecha_compra;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    public HashMap drop_sangre(){
        HashMap<String, String> drop_compra = new HashMap();
        try{
            cn = new Conexion();
            String query = "select idcompra as idcompra, no_orden_compra from compras;";
            cn.abrir_conexion();
            
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while(consulta.next()){
                drop_compra.put(consulta.getString("idcompra"), consulta.getString("no_orden_compra"));
            }
            cn.cerrar_conexion();
            
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        
        return drop_compra;
    } 
    
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     cn = new Conexion();
     cn.abrir_conexion();
      String query = "SELECT c.idcompra as id,c.no_orden_compra,p.idproveedor,c.fecha_orden,c.fecha_ingreso, p.proveedor FROM compras as c inner join proveedores as p on c.idproveedor = p.idproveedor;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","no_orden_compra","idproveedor","fecha_orden","fecha_ingreso","proveedor"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[6];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("no_orden_compra");
          datos[2] = consulta.getString("idproveedor");
          datos[3] = consulta.getString("fecha_orden");
          datos[4] = consulta.getString("fecha_ingreso");
          datos[5] = consulta.getString("proveedor");
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
            String query = "INSERT INTO compras (no_orden_compra, idproveedor, fecha_orden) VALUES (?, ?, ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getNo_orden_compra());
            parametro.setInt(2, this.getIdproveedor());
            parametro.setString(3, this.getFecha_compra());
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
            String query = "UPDATE compras SET no_orden_compra = ?, idproveedor = ?, fecha_orden = ? WHERE idcompra = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getNo_orden_compra());
            parametro.setInt(2, this.getIdproveedor());
            parametro.setString(3, this.getFecha_compra());
            parametro.setInt(4, this.getIdcompra());
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
            String query = "DELETE FROM compras WHERE idcompra = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdcompra());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
