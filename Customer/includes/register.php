<?php
require_once '../includes/db_connect.php';

if(!empty(filter_input(INPUT_POST, 'register'))){
    $fName = filter_input(INPUT_POST, 'fName');
    $lName = filter_input(INPUT_POST, 'lName');
    $username = filter_input(INPUT_POST, 'username');
    $pass = filter_input(INPUT_POST, 'pass');
    $address = filter_input(INPUT_POST, 'address');
    $email = filter_input(INPUT_POST, 'email');
    $cNumber = filter_input(INPUT_POST, 'cNumber');
    $passConf = filter_input(INPUT_POST, 'passConf');

    $query = "INSERT INTO customer (firstName, lastName, userName, password, address, email, contactNumber, status) VALUES ('$fName','$lName','$username','$pass','$address','$email','$cNumber','0')";
    $result = mysqli_query($conn, $query);
    
    if($result){
        echo '<div class="alert alert-success">You have successfully registered, please wait until your account is verified before logging in.</div>';
    } else {
        die("Database error");
    }
}

