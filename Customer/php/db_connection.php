<?php

$database = "handyzeb";
$user = "root";
$password = "";
$host = "localhost";

$conn = mysqli_connect($host, $user, $password, $database);
    if (!$conn) {
        exit('Connection Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
    }
    
session_start();
$_SESSION['conn'] = $conn;