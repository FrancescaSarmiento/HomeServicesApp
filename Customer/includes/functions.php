<?php

function checkLogin($row, $username){
    session_start();
    if($row == 1){
        $_SESSION['user'] = $username;
        header('location: ../pages/main.php?page=home');
    } else {
        $url = "http://" . filter_input(INPUT_SERVER, 'HTTP_HOST') . "/try/pages/login.php";
        echo '<div class="alert alert-danger">Username or password was incorrect, please try again.</div>';
        echo '<script>window.location.assign('.$url.')</script>';
    }
}

function loggedin() {
    if (isset($_SESSION['user']) && !empty($_SESSION['user'])){
        return true;
    } else {
        return false;
    }
}

function getTitle($title){
    switch($title){
        case "login.php":
            echo "Login";
            break;
        case "register.php":
            echo "Register";
            break;
        case "home.php":
            echo "Home";
            break;
    }
}