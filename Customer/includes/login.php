<?php
require_once 'db_connect.php';

if(!empty(filter_input(INPUT_POST, 'login'))){
    $username = filter_input(INPUT_POST, 'username');
    $pass = filter_input(INPUT_POST, 'pass');

    $query = "SELECT idNum, userType, status, firstName from user join customer on user.idNum=customer.custId WHERE userName = '$username' AND password = '$pass'";
    $result = mysqli_query($conn, $query); 
    $row = mysqli_num_rows($result);
    $rows = mysqli_fetch_assoc($result);
    
    session_start();

    if($row == 1){
        if($rows['userType'] == 'Customer'){
            if($rows['status'] == 1){
                $_SESSION['last_activity'] = time();
                $_SESSION['expire_time'] = 30 * 60; //30min
                $_SESSION['userID'] = $rows['idNum'];
                $_SESSION['firstName'] = $rows['firstName'];
                header('Location: ../pages/main.php?page=home');
            } else {
                echo '<div class="alert alert-danger">Your account has not yet been validated.</div>';
                echo '<script>window.location.assign(../pages/login.php)</script>';
            }
        } else {
            echo '<div class="alert alert-danger">You are trying to login as a customer.</div>';
            echo '<script>window.location.assign(../pages/login.php)</script>';
            }
    } else {
            echo '<div class="alert alert-danger">Username or password was incorrect, please try again.</div>';
            echo '<script>window.location.assign(../pages/login.php)</script>';
    }
    
    mysqli_free_result($result);
}