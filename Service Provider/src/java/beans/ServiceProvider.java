package beans;

public class ServiceProvider {
    private String firstName;
    private String lastName;
    private String userName;
    private String password;
    private String email;
    private String contactNumber;

    public ServiceProvider(String firstName, String lastName, String userName, String password, String email, String contactNumber) {
        setFirstName(firstName);
        setLastName(lastName);
        setUserName(userName);
        setPassword(password);
        setEmail(email);
        setContactNumber(contactNumber);
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
}
