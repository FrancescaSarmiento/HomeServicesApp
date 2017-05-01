<?php

function loggedin($user) {
    if (!empty($user)){
        return true;
    } else {
        return false;
    }
}

function logout(){
    session_destroy();
    return '../login.php';
}

function getUser($conn, $user){
    $query = "SELECT firstName from customer where userName = '$user'";
    $result = mysqli_query($conn, $query);
    return $result;
}