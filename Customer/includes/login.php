<?php
require_once 'db_connect.php';

if(!empty(filter_input(INPUT_POST, 'login'))){
    $username = filter_input(INPUT_POST, 'userName');
    $pass = filter_input(INPUT_POST, 'pass');

    $query = "SELECT * from user join customer on user.idNum=customer.custId WHERE userName = '$username' AND password = '$pass'";
    $result = mysqli_query($conn, $query); 
    $row = mysqli_num_rows($result);
    $rows = mysqli_fetch_assoc($result);
    
    session_start();

    if($row == 1){
        $_SESSION['last_activity'] = time();
        $_SESSION['expire_time'] = 30*60; //30min
        $_SESSION['userID'] = $rows['idNum'];
        $_SESSION['firstName'] = $rows['firstName'];
        $_SESSION['lastName'] = $rows['lastName'];
        header('Location: ../pages/main.php?page=home');
     
    } else {
            echo '<div class="alert alert-danger">Your password was incorrect, please try again.</div>';
            echo '<script>window.location.assign(../login.php)</script>';
    }
    
    mysqli_free_result($result);
}