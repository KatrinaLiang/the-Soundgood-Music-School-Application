package se.kth.iv1351.schooljdbc.integration;

public class SchoolDBException extends Exception{
    public SchoolDBException(String reason){
        super(reason);
    }
    public SchoolDBException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }
}
