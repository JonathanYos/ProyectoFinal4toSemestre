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
public class Venta_Detalle {
    public int idventadetalle,idventa,idproducto,cantidad;
    public float precio_unitario;
    private Conexion cn;

    public Venta_Detalle(){}
    public Venta_Detalle(int idventadetalle, int idventa, int idproducto, int cantidad, float precio_unitario) {
        this.idventadetalle = idventadetalle;
        this.idventa = idventa;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
    }

    public int getIdventadetalle() {
        return idventadetalle;
    }

    public void setIdventadetalle(int idventadetalle) {
        this.idventadetalle = idventadetalle;
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
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

    public float getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(float precio_unitario) {
        this.precio_unitario = precio_unitario;
    }
 
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     cn = new Conexion();
     cn.abrir_conexion();
      String query = "SELECT d.idventa_detalle as id,v.idVenta,p.idProducto,d.cantidad,d.precio_unitario,p.producto,v.no_factura,v.serie,v.fecha_factura,c.idCliente,e.idEmpleado,v.fecha_ingreso,c.nombres as nombre_cliente,e.nombres as nombre_empleado FROM ventas_detalle as d inner join productos as p on d.idProducto = p.idproducto inner join ventas as v on d.idVenta = v.idventa  inner join clientes as c on v.idcliente = c.idcliente inner join empleados as e on v.idEmpleado = e.idempleado;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","idventa","idproducto","cantidad","precio_unitario","producto","no_factura","serie","fecha_factura","idCliente","idEmpleado","fecha_ingreso","nombre_cliente","nombre_empleado"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[14];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("idventa");
          datos[2] = consulta.getString("idproducto");
          datos[3] = consulta.getString("cantidad");
          datos[4] = consulta.getString("precio_unitario");
          datos[5] = consulta.getString("producto");
          datos[6] = consulta.getString("no_factura");
          datos[7] = consulta.getString("serie");
          datos[8] = consulta.getString("fecha_factura");
          datos[9] = consulta.getString("idCliente");
          datos[10] = consulta.getString("idEmpleado");
          datos[11] = consulta.getString("fecha_ingreso");
          datos[12] = consulta.getString("nombre_cliente");
          datos[13] = consulta.getString("nombre_empleado");
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
            String query = "INSERT INTO ventas_detalle (idventa, idproducto, cantidad, precio_unitario) VALUES (?, ?, ?, ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdventa());
            parametro.setInt(2, this.getIdproducto());
            parametro.setInt(3, this.getCantidad());
            parametro.setFloat(4, this.getPrecio_unitario());
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
            String query = "UPDATE ventas_detalle SET idventa = ?, idproducto = ?, cantidad = ?, precio_unitario = ? WHERE idventa_detalle = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdventa());
            parametro.setInt(2, this.getIdproducto());
            parametro.setInt(3, this.getCantidad());
            parametro.setFloat(4, this.getPrecio_unitario());
            parametro.setInt(5, this.getIdventadetalle());
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
            String query = "DELETE FROM ventas_detalle WHERE idventa_detalle = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdventadetalle());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
