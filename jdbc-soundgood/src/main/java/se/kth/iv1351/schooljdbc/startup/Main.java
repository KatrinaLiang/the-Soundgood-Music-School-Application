package se.kth.iv1351.schooljdbc.startup;

import se.kth.iv1351.schooljdbc.integration.SchoolDBException;
import se.kth.iv1351.schooljdbc.view.BlockingInterpreter;
import se.kth.iv1351.schooljdbc.controller.Controller;

/**
 * Starts the bank client.
 */
public class Main {
	public static void main(String[] args) throws SchoolDBException {
        try {
            new BlockingInterpreter(new Controller()).handleCmds();

        } catch (SchoolDBException e){
            System.out.println("Could not connect to Bank db.");
            e.printStackTrace();
        }
    }
}
