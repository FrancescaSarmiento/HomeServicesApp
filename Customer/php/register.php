<?php
require_once 'db_connection.php';

if (filter_input(INPUT_POST, 'register') == 'Register') {
    $fName = filter_input(INPUT_POST, 'firstname');
    $lName = filter_input(INPUT_POST, 'lastname');
    $email = filter_input(INPUT_POST, 'email');
    $address = filter_input(INPUT_POST, 'address');
    $cNumber = filter_input(INPUT_POST, 'cNumber');
    $userName = filter_input(INPUT_POST, 'username');
    $pass = filter_input(INPUT_POST, 'password');
    $passV = filter_input(INPUT_POST, 'passwordConfirmation');
    
    $insert = "INSERT INTO customer(firstName, lastName, userName, password, address, email, contactNumber, status) VALUES ('$fName','$lName','$userName','$pass','$address','$email','$cNumber', 0)";
    $query = mysqli_query($conn, $insert) or die(mysqli_error($conn));
    
    echo "<script>alert('Thank you for registering, you can login once your account has been validated.')</script>";
    echo "<script>window.location.assign('../index.php');</script>";
} else {
    exit(error_log("Oops something went wrong"));
}

mysqli_close($conn);