
package br.com.fatecpg.cars;

import java.util.ArrayList;


public class Customers {
    private long id;
    private String name;
    private String rg;
    private String cpf;
    private String address;
    private String telephone;
    private String email;

    public Customers(Long id, String name, String rg, String cpf, String address, String telephone, String email) {
        this.id = id;
        this.name = name;
        this.rg = rg;
        this.cpf = cpf;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public static Customers getCustomers(String name, String rg)throws Exception{
        String SQL = "SELECT * FROM CUSTOMERS "
                + "WHERE name = ? AND rg = ?";
        ArrayList<Object[]> list = DataBaseConnector.getQuery(SQL, new Object[]{});
        if(list.isEmpty()){
            return null;
        } else {
            Object row[] = list.get(0);
            Customers c = new Customers (
                    
                    (long)row[0]
                    ,(String) row[1]
                    ,(String) row[2]
                    ,(String) row[3]
                    ,(String) row[4]
                    ,(String) row[5]
                    ,(String) row[6]);
            
            return c;
        }
        
    }
    
    public static ArrayList<Customers> getCustomers() throws Exception{
        String SQL = "SELECT * FROM CUSTOMERS";
        ArrayList<Customers> customers = new ArrayList<>();
        ArrayList<Object[]> list = DataBaseConnector.getQuery(SQL, new Object[]{});
        for(int i=0; i<list.size(); i++){
            Object row[] = list.get(i);
            Customers c = new Customers (
                    
                    (long)row[0]
                    ,(String) row[1]
                    ,(String) row[2]
                    ,(String) row[3]
                    ,(String) row[4]
                    ,(String) row[5]
                    ,(String) row[6]);
            
            customers.add(c);
        }
        return customers;
    }
    
    public static void addCustomers(String name, String rg, String cpf, String address, String telephone, String email) 
            throws Exception{
        String SQL = "INSERT INTO USERS VALUES ("
                + "default"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ")";
                
        Object parameters[] = {name, rg, cpf, address, telephone, email};
        DataBaseConnector.execute(SQL, parameters);
    }
    
    public static void removeCustomers(long id) 
            throws Exception{
        String SQL = "DELETE FROM CUSTOMERS WHERE ID = ?";
                
        Object parameters[] = {id};
        DataBaseConnector.execute(SQL, parameters);
    }

    
    
}
