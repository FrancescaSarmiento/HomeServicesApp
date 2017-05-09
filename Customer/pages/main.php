<?php 

require '../includes/header.php';
require '../includes/db_connect.php';

session_start();

//checks if session expired
if($_SESSION['last_activity'] < time()-$_SESSION['expire_time']){
    echo "<script>alert('Your session has expired, please login again');window.location.assign('../login.php')</script>";
} else {
    $_SESSION['last_activity'] = time();
}

//retrieve's user's idNum
$userID = $_SESSION['userID'];

//checks if the user's session exists
 if (empty($userID)){
    echo "<script>alert('Please login');window.location.assign('../login.php')</script>";
 }

//checks url input from navigation
$page = filter_input(INPUT_GET, 'page');

require 'nav.php';

//checks which page to display, if not included, will redirect to login

switch ($page){
    case "home":
        echo "<div class='container'>";
        require_once 'home.php';
        echo "</div>";
        break;
    case "about":
        echo "<div class='container'>";
        require_once 'about.php';
        echo "</div>";
        break;
    case "services";
        echo "<div class='container'>";
        require_once 'services.php';
        echo "</div>";
        break;
    case "messages";
        echo "<div class='container'>";
        require_once 'messages.php';
        echo "</div>";
        break;
    case "acctInfo":
        echo "<div class='container'>";
        require_once 'acctInfo.php';
        echo "</div>";
        break;
    case "transHist":
        echo "<div class='container'>";
        require_once 'transHist.php';
        echo "</div>";
        break;
}

require '../includes/footer.php';
