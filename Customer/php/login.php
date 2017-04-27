<?php
require_once 'db_connection.php';

if (!filter_input(INPUT_POST, 'login')) {
    $uName = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'uName'));
    $pass = mysqli_real_escape_string($conn, filter_input(INPUT_POST, 'pass'));
    $sel_user = "SELECT * FROM customer WHERE userName ='$uName' AND password='$pass'";
    $query = mysqli_query($conn,$sel_user);
    $check_user = mysqli_num_rows($query);
    
    if ($check_user > 0) {
        $_SESSION['userName']=$uName;
        echo "<script>window.location.assign('../home-page.php');</script>";
    } else {
        echo "<script>alert('Username or Password is incorrect, try again.')</script>";
        echo "<script>window.location.assign('login-page.php');</script>";
    }
} else {
    exit(error_log("Oops something went wrong"));
}

mysqli_close($conn);