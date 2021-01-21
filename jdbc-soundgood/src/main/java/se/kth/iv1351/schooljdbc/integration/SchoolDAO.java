/**
 * This data access object (DAO) encapsulates all database calls in the bank
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
package se.kth.iv1351.schooljdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SchoolDAO {

    private final String url = "jdbc:postgresql://localhost:5432/soundgood";
    private final String user = "postgres";
    private final String password = "example";
    private Connection connection;
    
    private PreparedStatement findInstrumentByTypeStmt;
    private PreparedStatement createRentalStmt;
    private PreparedStatement decreaseQuantityStmt;
    private PreparedStatement checkNoOfRentalsStmt;
    private PreparedStatement terminateRentalStmt;
    private PreparedStatement increaseQuantityStmt;

    public SchoolDAO() throws SchoolDBException{
        try{
            connectToSchoolDB();
            prepareStatements();

        } catch (SQLException | ClassNotFoundException e) {
            throw new SchoolDBException("Could not connect to datasource.", e);
        }
    }

    private void connectToSchoolDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection(url, user, password);
        System.out.println("Connected to the PostgreSQL server successfully.");
        connection.setAutoCommit(false);
    }

    public void findInstrumentByType(String type) throws SchoolDBException{
        String failureMsg = "Could not search for a specific type of instrument.";
        ResultSet rs = null;

        try{
        	findInstrumentByTypeStmt.setString(1, type);
            rs = findInstrumentByTypeStmt.executeQuery();
            connection.commit();
            
            while(rs.next()){
                String s = rs.getString("type");
                String s1 = rs.getString("brand");
                int i = rs.getInt("rent_per_month");
                System.out.println("Type: " + s + "   Brand: " + s1 + "    Rent/month: "+i);
            }
           
        } catch (SQLException e){
        	e.printStackTrace();
            handleException(failureMsg, e);
        }finally {
            closeResultSet(failureMsg, rs);
        }
        System.out.println("    findInstrumentByType done");

    }

    public void createRental(int studentID, int instrumentID) throws SchoolDBException{
    	System.out.println("Student with ID: " + studentID +" trying to rent instrument " + instrumentID);
        String failureMsg = "Could not rent instrument: " + instrumentID;
        int updatedRental = 0;
        int updatedInstrument = 0;
        int nr = 0;
        ResultSet rs = null;
        
        try{
            // check if number of ongoing rentals = 2 
        	checkNoOfRentalsStmt.setInt(1, studentID);
        	rs = checkNoOfRentalsStmt.executeQuery();
        	while(rs.next()) {
        		nr = rs.getInt("count");
        		System.out.println("Number of ongoing rentals: " + nr);
        	}
        	
            if(nr == 2) {
            	connection.commit();
            	System.out.println("Rental limit exceeded");
            }else {
	        	createRentalStmt.setInt(1, studentID);
	            createRentalStmt.setInt(2, instrumentID);
	            updatedRental = createRentalStmt.executeUpdate();
	            //System.out.println("INSERT done...");
	            decreaseQuantityStmt.setInt(1, instrumentID);
	            updatedInstrument = decreaseQuantityStmt.executeUpdate();
	            //System.out.println("UPDATE done...");
	
	            if (updatedRental != 1 || updatedInstrument != 1) {
	                handleException(failureMsg, null);
	            }
	            System.out.println("New rental has been created successfully!");
	            connection.commit();
            }
    
        }catch (SQLException e){
        	e.printStackTrace();
            handleException(failureMsg, e);
        }finally {
            closeResultSet(failureMsg, rs);
        }
    }
    
    public void endRental(int studentID, int rentalID) throws SchoolDBException{
    	System.out.println("Student with ID: " + studentID +" trying to end rental " + rentalID);
    	 String failureMsg = "Could not terminate rental: " + rentalID;
    	 int updatedRentals = 0;
    	 int updatedInstruments = 0;
    	 
    	try{
    		terminateRentalStmt.setInt(1, studentID);
    		terminateRentalStmt.setInt(2, rentalID);
    		updatedRentals = terminateRentalStmt.executeUpdate();
    		
    		increaseQuantityStmt.setInt(1,  rentalID);
    		updatedInstruments = increaseQuantityStmt.executeUpdate();
    		
    		if (updatedRentals != 1 || updatedInstruments != 1) {
                handleException(failureMsg, null);
            }
    		connection.commit();
    		System.out.println("Rental has been terminated successfully!");
    		
    	}catch (SQLException e){
        	e.printStackTrace();
            handleException(failureMsg, e);
        }
    	
    }


    private void prepareStatements() throws SQLException {
        findInstrumentByTypeStmt = connection.prepareStatement("SELECT type, brand, rent_per_month " +
        		" FROM instrument " +
        		" WHERE type = ? AND quantity_in_stock > 0 " +
        		" GROUP BY type, brand, rent_per_month ");
    	
        createRentalStmt = connection.prepareStatement("INSERT INTO instrument_rental (rent_date, student_id, instrument_id)    " +
                " VALUES (CURRENT_DATE, ?, ?)");

        decreaseQuantityStmt = connection.prepareStatement("UPDATE instrument SET quantity_in_stock = quantity_in_stock - 1    " +
                " WHERE id = ? AND quantity_in_stock > 0");
        
        checkNoOfRentalsStmt = connection.prepareStatement(" SELECT COUNT(*) FROM instrument_rental "
        		+ " WHERE student_id = ? AND rent_due IS NULL ");
        
        terminateRentalStmt = connection.prepareStatement("UPDATE instrument_rental "+
        		"SET rent_due = CURRENT_DATE " +
        		"WHERE student_id = ? AND renting_id = ? AND rent_due IS NULL");
        
        increaseQuantityStmt = connection.prepareStatement(" UPDATE instrument " +
        		" SET quantity_in_stock = quantity_in_stock + 1 " +
        		" WHERE id = ( " +
        		" SELECT instrument_id " +
        		" FROM instrument_rental WHERE renting_id = ?) ");
    }
    private void handleException(String failureMsg, Exception cause) throws SchoolDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SchoolDBException(failureMsg, cause);
        } else {
            throw new SchoolDBException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SchoolDBException {
        try {
            result.close();
        } catch (Exception e) {
            throw new SchoolDBException(failureMsg + " Could not close result set.", e);
        }
    }


}
