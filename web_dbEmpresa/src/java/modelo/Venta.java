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
public class Venta {
    public int idventa, no_factura, idcliente, idempleado; 
    public String serie, fecha_factura, fecha_ingreso;
    private Conexion cn;

    public Venta(){}
    public Venta(int idventa, int no_factura, int idcliente, int idempleado, String serie, String fecha_factura, String fecha_ingreso) {
        this.idventa = idventa;
        this.no_factura = no_factura;
        this.idcliente = idcliente;
        this.idempleado = idempleado;
        this.serie = serie;
        this.fecha_factura = fecha_factura;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
    }

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public int getIdempleado() {
        return idempleado;
    }

    public void setIdempleado(int idempleado) {
        this.idempleado = idempleado;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
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
            String query = "select idventa as idventa, no_factura from ventas;";
            cn.abrir_conexion();
            
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while(consulta.next()){
                drop_compra.put(consulta.getString("idventa"), consulta.getString("no_factura"));
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
      String query = "SELECT v.idventa as id, v.no_factura, v.serie, v.fecha_factura, c.idCliente, e.idEmpleado, v.fecha_ingreso, c.nombres, e.nombres FROM ventas as v inner join clientes as c on v.idCliente = c.idcliente inner join empleados as e on v.idEmpleado = e.idempleado;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","no_factura","serie","fecha_factura","idCliente","idEmpleado","fecha_ingreso","nombres","nombres"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[9];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("no_factura");
          datos[2] = consulta.getString("serie");
          datos[3] = consulta.getString("fecha_factura");
          datos[4] = consulta.getString("idCliente");
          datos[5] = consulta.getString("idEmpleado");
          datos[6] = consulta.getString("fecha_ingreso");
          datos[7] = consulta.getString("nombres");
          datos[8] = consulta.getString("nombres");
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
            String query = "INSERT INTO ventas (no_factura, serie, fecha_factura, idCliente, idEmpleado) VALUES (?, ?, ?, ?, ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getNo_factura());
            parametro.setString(2, this.getSerie());
            parametro.setString(3, this.getFecha_factura());
            parametro.setInt(4, this.getIdcliente());
            parametro.setFloat(5, this.getIdempleado());
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
            String query = "UPDATE ventas SET no_factura = ?, serie = ?, fecha_factura = ?. idCliente = ?, idEmpleado = ? WHERE idventa = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getNo_factura());
            parametro.setString(2, this.getSerie());
            parametro.setString(3, this.getFecha_factura());
            parametro.setInt(4, this.getIdcliente());
            parametro.setFloat(5, this.getIdempleado());
            parametro.setInt(6, this.getIdventa());
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
            String query = "DELETE FROM ventas WHERE idventa = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdventa());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
