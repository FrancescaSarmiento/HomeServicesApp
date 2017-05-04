<?php 

include '../includes/header.php';

session_start();
    
//checks if the user loggedin
if (!loggedin()){
    echo "<script>alert('Please log in');window.location.assign('login.php')</script>";
}
    
$user = $_SESSION['user'];

include 'nav.php';

//checks url input from navigation
$page = filter_input(INPUT_GET, 'page');

switch ($page){
    case "home":
        include_once 'home.php';
        break;
    case "about":
        include_once 'about.php';
        break;
    case "services";
        include_once 'services.php';
        break;
    case "messages";
        include_once 'messages.php';
        break;
    case "acctInfo":
        include_once 'acctInfo.php';
        break;
    case "transHist":
        include_once 'transHist.php';
        break;
}
?>
    
<?php include '../includes/footer.php';
