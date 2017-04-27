<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <form action="php/register.php" method="post">
            <div class="registerForm-container">
                <label>First Name:</label>
                <input type="text" name="fName" placeholder="Enter First Name" required/>
                <lable>Last Name:</lable>
                <input type="text" name="lName" placeholder="Enter Last Name" required/>
                <label>Email:</label>
                <input type="text" name="email" placeholder="Enter Email" />
                <label>Address: (House #/Street/Barangay/City or Province)</label>
                <input type="text" name="address" placeholder="Enter Address" required/>
                <label>Contact Number:</label>
                <input type="text" name="cNumber" placeholder="Enter Contact Number" required/>
                <lable>Username: </lable>
                <input type="text" name="uName" placeholder="Enter a username" required/>
                <label>Password:</label>
                <input type="password" name="pass" placeholder="Enter Password" required/>
                <label>Re-enter Password:</label>
                <input type="password" name="passV" placeholder="Re-enter Password" required/>
                <button type="submit">Register</button>
            </div>
        </form>
    </body>
</html>