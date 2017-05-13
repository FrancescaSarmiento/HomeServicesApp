<?php 

require '../includes/header.php';
require '../includes/db_connect.php';

session_start();

//checks if session expired
if($_SESSION['last_activity'] < time()-$_SESSION['expire_time']){
    header('Location: expire.php');
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
        require_once 'home.php';
        break;
    case "about":
        require_once 'about.php';
        break;
    case "services";
        require_once 'services.php';
        break;
    case "messages";
        require_once 'messages.php';
        break;
    case "acctInfo":
        require_once 'acctInfo.php';
        break;
    case "transHist":
        require_once 'transHist.php';
        break;
    case "notifications":
        require_once 'notifications.php';
        break;
}

require '../includes/footer.php';
