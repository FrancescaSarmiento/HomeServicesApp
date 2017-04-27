<?php
require_once 'db_connection.php';

if (!filter_input(INPUT_POST, 'register')) {
    $fName = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'fName'));
    $lName = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'lName'));
    $email = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'email'));
    $address = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'address'));
    $cNumber = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'cNumber'));
    $userName = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'userName'));
    $pass = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'pass'));
    $passV = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'passV'));
    
    $insert = "INSERT INTO customer(firstName, lastName, userName, password, address, email, contactNumber, status) VALUES ('$fName','$lName','$userName','$password','$address','$email','$cNumber', 0)";
    $query = mysqli_query($conn, $insert) or die();
    
    echo "<script>alert('Thank you for registering, you can login once your account has been validated.')</script>";
    echo "<script>window.location.assign('../login-page.php');</script>";
} else {
    exit(error_log("Oops something went wrong"));
}

mysqli_close($conn);