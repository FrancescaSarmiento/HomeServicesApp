package edu.slu.scis.webtek.demo.beans;

public class ServiceProvider {
    private int idNum;
    private String userName;
    private String firstName;
    private String lastName;
    private String email;
    private String contactNumber;
    private String workingDays;
    private byte rating;
    private boolean availability;

    public ServiceProvider(){
        idNum = 0;
        userName = "GenericUser";
        firstName = "First";
        lastName = "Last";
        email = "sample@email.com";
        contactNumber = "09153478922";
        workingDays = "Sun,Mon,Tue,Wed,Thu,Fri,Sat";
        rating = 5;
        availability = true;
    }
    public ServiceProvider(int idNum, String userName, String firstName, String lastName, String email, String contactNumber, String workingDays, byte rating, boolean availability) {
        this.idNum = idNum;
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNumber = contactNumber;
        this.workingDays = workingDays;
        this.rating = rating;
        this.availability = availability;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public int getIdNum() {
        return idNum;
    }

    public byte getRating() {
        return rating;
    }

    public String getUserName() {
        return userName;
    }

    public String getWorkingDays() {
        return workingDays;
    }

    public boolean isAvailability() {
        return availability;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setIdNum(int idNum) {
        this.idNum = idNum;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setRating(byte rating) {
        this.rating = rating;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setWorkingDays(String workingDays) {
        this.workingDays = workingDays;
    }    

    @Override
    public String toString() {
        return userName+" "+firstName+" "+lastName+" "+contactNumber+" "+email+" "+workingDays+" "+rating+" "+email+" "+availability;
    }
}