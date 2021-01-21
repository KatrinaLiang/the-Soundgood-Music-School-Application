/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */

package se.kth.iv1351.schooljdbc.controller;

import se.kth.iv1351.schooljdbc.integration.SchoolDAO;
import se.kth.iv1351.schooljdbc.integration.SchoolDBException;

public class Controller {
	private final SchoolDAO schoolDb;

    public Controller() throws SchoolDBException {
        this.schoolDb = new SchoolDAO();
    }

    public void getInstrument(String type) throws SchoolDBException{
        try{
            schoolDb.findInstrumentByType(type);
        } catch(Exception e){
            System.out.println(e);
        }
    }

    public void rentInstrument(int studentID, int instrumentID) throws SchoolDBException{
        try{
            schoolDb.createRental(studentID, instrumentID);
        } catch(Exception e){
            System.out.println(e);
        }
    }
    
    public void  terminateRental(int studentID, int rentalID) throws SchoolDBException{
    	try {
    		schoolDb.endRental(studentID, rentalID);
    	}catch(Exception e) {
    		System.out.println(e);
    	}
    }
}
