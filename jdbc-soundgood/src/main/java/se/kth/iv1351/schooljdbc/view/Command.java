package se.kth.iv1351.schooljdbc.view;

/**
 * Defines all commands that can be performed by a user of the chat application.
 */
public enum Command {
    /**
     * Lists all instruments of a specific type.
     */
    LIST,

    /**
     * Rent a specific instrument given student_id and instrument_id
     */
    RENT,
    
    /**
     * Terminate a rental given student_id and renting_id.
     */
    TERMINATE,
    
    /**
     * Leave the chat application.
     */
    QUIT,
    /**
     * None of the valid commands above was specified.
     */
    ILLEGAL_COMMAND
}
