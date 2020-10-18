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
public class Empleado {
    public int idempleado, idpuesto, genero;
    public String nombres, apellidos, direccion, telefono, dpi, fecha_nacimiento, fecha_inicio_labores, fecha_ingreso;
    private Conexion cn;

    public Empleado(){}
    public Empleado(int idempleado, int idpuesto, int genero, String nombres, String apellidos, String direccion, String telefono, String dpi, String fecha_nacimiento, String fecha_inicio_labores, String fecha_ingreso) {
        this.idempleado = idempleado;
        this.idpuesto = idpuesto;
        this.genero = genero;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.dpi = dpi;
        this.fecha_nacimiento = fecha_nacimiento;
        this.fecha_inicio_labores = fecha_inicio_labores;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getIdempleado() {
        return idempleado;
    }

    public void setIdempleado(int idempleado) {
        this.idempleado = idempleado;
    }

    public int getIdpuesto() {
        return idpuesto;
    }

    public void setIdpuesto(int idpuesto) {
        this.idpuesto = idpuesto;
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getFecha_inicio_labores() {
        return fecha_inicio_labores;
    }

    public void setFecha_inicio_labores(String fecha_inicio_labores) {
        this.fecha_inicio_labores = fecha_inicio_labores;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    public HashMap drop_sangre(){
        HashMap<String, String> drop = new HashMap();
        try{
            cn = new Conexion();
            String query = "select idempleado as idempleado, nombres from empleados;";
            cn.abrir_conexion();
            
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while(consulta.next()){
                drop.put(consulta.getString("idempleado"), consulta.getString("nombres"));
            }
            cn.cerrar_conexion();
            
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        
        return drop;
    } 
    
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     cn = new Conexion();
     cn.abrir_conexion();
      String query = "SELECT e.idEmpleado as id,e.nombres,e.apellidos,e.direccion,e.telefono,e.dpi,e.genero,e.fecha_nacimiento,p.puesto,p.idpuesto,e.fecha_inicio_labores,e.fecha_ingreso FROM empleados as e inner join puestos as p on e.idPuesto = p.idpuesto;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","nombres","apellidos","direccion","telefono","dpi","genero","fecha_nacimiento","puesto","idpuesto","fecha_inicio_labores","fecha_ingreso"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[12];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("nombres");
          datos[2] = consulta.getString("apellidos");
          datos[3] = consulta.getString("direccion");
          datos[4] = consulta.getString("telefono");
          datos[5] = consulta.getString("dpi");
          datos[6] = consulta.getString("genero");
          datos[7] = consulta.getString("fecha_nacimiento");
          datos[8] = consulta.getString("puesto");
          datos[9] = consulta.getString("idpuesto");
          datos[10] = consulta.getString("fecha_inicio_labores");
          datos[11] = consulta.getString("fecha_ingreso");
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
            String query = "INSERT INTO empleados (nombres, apellidos, direccion, telefono, dpi, genero, fecha_nacimiento, idPuesto, fecha_inicio_labores) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1, this.getNombres());
            parametro.setString(2, this.getApellidos());
            parametro.setString(3, this.getDireccion());
            parametro.setString(4, this.getTelefono());
            parametro.setString(5, this.getDpi());
            parametro.setInt(6, this.getGenero());
            parametro.setString(7, this.getFecha_nacimiento());
            parametro.setInt(8, this.getIdpuesto());
            parametro.setString(9, this.getFecha_inicio_labores());
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
            String query = "UPDATE empleados SET nombres = ?, apellidos = ?, direccion = ?, telefono =?, dpi = ?, genero =  ?, fecha_nacimiento = ?, idPuesto = ?, fecha_inicio_labores = ? WHERE idEmpleado = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1, this.getNombres());
            parametro.setString(2, this.getApellidos());
            parametro.setString(3, this.getDireccion());
            parametro.setString(4, this.getTelefono());
            parametro.setString(5, this.getDpi());
            parametro.setInt(6, this.getGenero());
            parametro.setString(7, this.getFecha_nacimiento());
            parametro.setInt(8, this.getIdpuesto());
            parametro.setString(9, this.getFecha_inicio_labores());
            parametro.setInt(10, this.getIdempleado());
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
            String query = "DELETE FROM empleados WHERE idEmpleado = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getIdempleado());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
