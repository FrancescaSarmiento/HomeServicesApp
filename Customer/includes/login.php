<?php
require_once '../includes/db_connect.php';

if(!empty(filter_input(INPUT_POST, 'login'))){
    $username = filter_input(INPUT_POST, 'username');
    $pass = filter_input(INPUT_POST, 'pass');

    $query = "SELECT * from customer WHERE userName = '$username' AND password = '$pass'";
    $result = mysqli_query($conn, $query);
    $row = mysqli_num_rows($result);
    
    checkLogin($row, $username);
}