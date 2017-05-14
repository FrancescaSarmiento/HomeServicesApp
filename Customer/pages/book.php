<?php
require '../includes/blockedPages.php';
require '../includes/functions.php';

if(!empty(filter_input(INPUT_POST, 'bookdate'))){
    
$bookdate=filter_input(INPUT_POST, 'bookdate');
$spname= filter_input(INPUT_POST, 'sp');
$service= filter_input(INPUT_POST, 'type');
$spId=filter_input(INPUT_POST, 'spid');
echo "Booking date: $bookdate <br>";
echo "Service Provider: $spname <br>";
echo "Service: $service <br>";
echo <<<frag
    <form action="../includes/booksuccessful.php" method="post">
        <input type="hidden" name="bookdate" value="$bookdate">
        <input type="hidden" name="sp" value="$spname">
        <input type="hidden" name="type" value="$service">
        <input type="hidden" name="spid" value="$spId">
        <button type="submit" name="confirm">Confirm</button>
    </form>
        <a href="?page=services&type=<?php echo $service ?>" type="button">Cancel</a>
frag;

    #insertinto($bookdate, $spname, $service, $spId, $userID, $conn);
   
    #function insertinto($bookdate, $spname, $service, $spId, $userID, $conn){
   if(!empty(filter_input(INPUT_POST, 'bookdate'))){
        
        if(insertBooking($service, $userID, $spId,$bookdate, $conn)){
            echo "<script>alert(Booking request was sent to the service provider. You will be notified once the service provider responded to your request. Thank you.)</script>";
            echo "<script>window.assign.location('main.php?page=service')</script>";
        }
        
    } else {
        echo "";
    }
/*
function insertbooking($date, $spname, $service, $userid, $spId, $conn){
    $serviceid = "SELECT serviceId from service where servicetype=$service";
echo $date;
    $insertquery = "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (NULL, '$userid', '$spId', '$serviceid', 'pending', '$date 00:00:00', NULL, NULL)";

    $result = mysqli_query($conn, $insertquery) or die();
}*/
}

