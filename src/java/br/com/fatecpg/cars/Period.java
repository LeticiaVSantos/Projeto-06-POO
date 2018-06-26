
package br.com.fatecpg.cars;

import java.util.ArrayList;
import java.util.Date;


public class Period {
    private long id;
    private String model;
    private String plate;
    private Date retirada;
    private Date hr_retirada;
    private Date dev;
    private Date hr_dev;
    private double price;

    public Period(long id, String model, String plate, Date retirada, Double par5) {
        this.id = id;
        this.model = model;
        this.plate = plate;
        this.retirada = retirada;
    }

    public Period(long id, String model, String plate, Date retirada, Date dev, Date hr_retirada, Date hr_dev, double price) {
        this.id = id;
        this.model = model;
        this.plate = plate;
        this.retirada = retirada;
        this.dev = dev;
        this.hr_retirada = hr_retirada;
        this.hr_dev = hr_dev;
        this.price = price;
    }
    
     public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getPlate() {
        return plate;
    }

    public void setPlate(String plate) {
        this.plate = plate;
    }

    public Date getRetirada() {
        return retirada;
    }

    public void setRetirada(Date retirada) {
        this.retirada = retirada;
    }

    public Date getDev() {
        return dev;
    }

    public void setDev(Date dev) {
        this.dev = dev;
    }

    public Date getHr_retirada() {
        return hr_retirada;
    }

    public void setHr_retirada(Date hr_retirada) {
        this.hr_retirada = hr_retirada;
    }

    public Date getHr_dev() {
        return hr_dev;
    }

    public void setHr_dev(Date hr_dev) {
        this.hr_dev = hr_dev;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    


    
    public static Period getPeriod(long id) throws Exception{
        String SQL = "SELECT * FROM CARS_PERIODS WHERE ID = ? ";
        ArrayList<Object[]> list = DataBaseConnector.getQuery(SQL, new Object[]{id});
        if(list.isEmpty()){
            return null;
        } else {
            Object row[] = list.get(0);
            Period p = new Period (
                    
                    (long)row[0]
                    ,(String) row[1]
                    ,(String) row[2]
                    ,(Date) row[3] 
                    ,(Date) row[4]
                    ,(Date) row[5]
                    ,(Date) row[6]
                    ,(Double) row[7]);
            
            return p;
        }
        
    }
    
    public static ArrayList<Period> getHistory(String date, String plate) throws Exception{
        ArrayList<Object[]> list = null;
        if(date == null && plate!=null){
            String SQL = "SELECT * FROM CARS_PERIODS ";
            SQL +=" WHERE plate = ?";
            SQL += " ORDER BY RETIRADA";
            list = DataBaseConnector.getQuery(SQL, new Object[]{plate});
        }else if(date != null && plate ==null){
            String SQL = "SELECT * FROM CARS_PERIODS ";
            SQL +=" WHERE VARCHAR(DATE(RETIRADA)) = ?";
            SQL += " ORDER BY RETIRADA";
            list = DataBaseConnector.getQuery(SQL, new Object[]{date});
        }else if(date != null && plate ==null){
            String SQL = "SELECT * FROM CARS_PERIODS ";
            SQL +=" WHERE VARCHAR(DATE(RETIRADA)) = ? AND plate = ?";
            SQL += " ORDER BY RETIRADA";
            list = DataBaseConnector.getQuery(SQL, new Object[]{date, plate});    
        }else{
            String SQL = "SELECT * FROM CARS_PERIODS ";
            SQL += " ORDER BY RETIRADA";
            list = DataBaseConnector.getQuery(SQL, new Object[]{});
        }
        ArrayList<Period> periods = new ArrayList<>();
        for(int i=0; i<list.size(); i++){
            Object row[] = list.get(i);
            Period p = new Period (
                    
                    (long)row[0]
                    ,(String) row[1]
                    ,(String) row[2]
                    ,(Date) row[3] 
                    ,(Date) row[4]
                    ,(Date) row[5]
                    ,(Date) row[6]
                    ,(Double) row[7]);
            
            periods.add(p);
        }
        return periods;
    }
    
    public static ArrayList<Period> getPeriods() throws Exception{
        String SQL = "SELECT * FROM CARS_PERIODS WHERE RETIRADA IS NULL ORDER BY DEV";
        ArrayList<Period> periods = new ArrayList<>();
        ArrayList<Object[]> list = DataBaseConnector.getQuery(SQL, new Object[]{});
        for(int i=0; i<list.size(); i++){
            Object row[] = list.get(i);
            Period p = new Period (
                    
                    (long)row[0]
                    ,(String) row[1]
                    ,(String) row[2]
                    ,(Date) row[3] 
                    ,(Date) row[4]
                    ,(Date) row[5]
                    ,(Date) row[6]
                    ,(Double) row[7]);
            
            periods.add(p);
        }
        return periods;
    }
    
    public static void addPeriod(String model, String plate, String retirada, String hr_retirada, String dev, String hr_dev) 
            throws Exception{
        String SQL = "INSERT INTO CARS_PERIODS VALUES("
                + "default"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ", ?"
                + ")";
                
        Object parameters[] = {model, plate, new Date()};
        DataBaseConnector.execute(SQL, parameters);
    }
    
    public static void finishPeriod(long id, double price) 
            throws Exception{
        String SQL = "UPDATE CARS_PERIODS "
                + "SET DEV = ? "
                + ", PRICE = ? "
                + "WHERE ID = ?";
                
        Object parameters[] = {new Date(), price, id};
        DataBaseConnector.execute(SQL, parameters);
    }

   

}
