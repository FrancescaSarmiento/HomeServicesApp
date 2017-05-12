<?php
require '../includes/blockedPages.php';
require '../includes/functions.php';
include 'main.php';
echo "Booking details <br><br>";
session_start();
if(!empty($_SESSION['last_activity']($_POST["book"]))){
    $bookdate=$_POST['bookdate'];
    $spname=$_POST['sp'];
    $service=$_POST['service'];
    $spId=$_POST['spid'];
}
echo "Booking date: $bookdate <br>";
echo "Service Provider: $spname <br>";
echo "Service: $service <br>";?>


<html>
<body>
    <form action="" method="post">
        <button type="submit" name="confirm">Confirm</button>
        <button type="submit" name="cancel">Cancel</button>
    </form>
<!--<a href="spservice.php?type=<?php echo $service ?>" type="button">Cancel</a>-->
</body>
</html>

<?php
    #insertinto($bookdate, $spname, $service, $spId, $userID, $conn);
   
    #function insertinto($bookdate, $spname, $service, $spId, $userID, $conn){
   if(isset( $_POST['confirm'])){
        
        insertBooking($service, $userID, $spId,$bookdate, $conn);
        header('Location: booksuccessful.php');
    } else {
        echo "";
    }

    if(isset($_POST['cancel'])){
        header('Location: spservice.php?type='.$service.'' );
    }
/*
function insertbooking($date, $spname, $service, $userid, $spId, $conn){
	$serviceid = "SELECT serviceId from service where servicetype=$service";
echo $date;
	$insertquery = "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (NULL, '$userid', '$spId', '$serviceid', 'pending', '$date 00:00:00', NULL, NULL)";

	$result = mysqli_query($conn, $insertquery) or die();
}*/
?>

