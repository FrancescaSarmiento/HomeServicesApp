<?php
require 'db_connection.php';

if (filter_input(INPUT_POST, 'login') == 'Login') {
    $uName = filter_input(INPUT_POST, 'username');
    $pass = filter_input(INPUT_POST, 'password');
    $sel_user = "SELECT * FROM customer WHERE userName ='$uName' AND password='$pass'";
    $query = mysqli_query($conn,$sel_user) or die(mysqli_error($conn));
    $check_user = mysqli_num_rows($query);

    if ($check_user > 0) {
        $_SESSION['loggedin'] = true;
        $_SESSION['user'] = $uName;
        header('location: ../pages/body.php');
    } else {
        echo "<script>alert('Username or Password is incorrect, try again.');window.location.assign('../pages/login.php')</script>";
    }
} else {
    exit(error_log("Oops something went wrong"));
}