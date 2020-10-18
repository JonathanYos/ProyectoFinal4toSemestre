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
public class Puesto {
    private int id_puestos;
    private String puesto;
    private Conexion cn;

    public Puesto(){}
    public Puesto(int id_puestos, String puesto) {
        this.id_puestos = id_puestos;
        this.puesto = puesto;
    }

    public int getId_puestos() {
        return id_puestos;
    }

    public void setId_puestos(int id_puestos) {
        this.id_puestos = id_puestos;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }
    
    public HashMap drop_sangre(){
        HashMap<String, String> drop = new HashMap();
        try{
            cn = new Conexion();
            String query = "select idpuesto as idpuesto, puesto from puestos;";
            cn.abrir_conexion();
            
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while(consulta.next()){
                drop.put(consulta.getString("idpuesto"), consulta.getString("puesto"));
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
      String query = "SELECT p.idpuesto as id,p.puesto FROM puestos as p;";
      ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
      String encabezado[] = {"id","puesto"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[2];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("puesto");
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
            String query = "INSERT INTO puestos (puesto) VALUES (?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1, this.getPuesto());
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
            String query = "UPDATE puestos SET  puesto = ? WHERE idpuesto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setString(1,this.getPuesto());
            parametro.setInt(2, this.getId_puestos());
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
            String query = "delete from puestos  where idpuesto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.getId_puestos());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
