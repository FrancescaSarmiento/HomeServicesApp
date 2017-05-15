<?php
require '../includes/blockedPages.php';
require '../includes/functions.php';

if(!empty(filter_input(INPUT_POST, 'spid'))){
    
$bookD=filter_input(INPUT_POST, 'bookdate');
$spname= filter_input(INPUT_POST, 'sp');
$serviceT= filter_input(INPUT_POST, 'type');
$sId=filter_input(INPUT_POST, 'spid');
$userID = filter_input(INPUT_POST, 'userID');
echo "Booking date: $bookD <br>";
echo "Service Provider: $spname <br>";
echo "Service: $serviceT <br>";
echo <<<frag
    <form action="../includes/booksuccessful.php" method="post">
        <input type="hidden" name="user" value="$userID">
        <input type="hidden" name="bookD" value="$bookD">
        <input type="hidden" name="name" value="$spname">
        <input type="hidden" name="sType" value="$serviceT">
        <input type="hidden" name="spId" value="$sId">
        <button class="btn-primary" type="submit" name="confirm">Confirm</button>
    </form>
        <a href="?page=services&type=<?php echo $serviceT ?>" type="button">Cancel</a>
frag;

    #insertinto($bookdate, $spname, $service, $spId, $userID, $conn);
   
    #function insertinto($bookdate, $spname, $service, $spId, $userID, $conn){
 /*  if(!empty(filter_input(INPUT_POST, 'bookD'))){
        $book = filter_input(INPUT_POST, 'bookD');
        $name = filter_input(INPUT_POST, 'name');
        $type = filter_input(INPUT_POST, 'sType');
        $id = filter_input(INPUT_POST, 'spId');
        if(insertBooking($type, $userID, $id,$book, $conn)){
            echo "<script>alert(Booking request was sent to the service provider. You will be notified once the service provider responded to your request. Thank you.)</script>";
            echo "<script>window.assign.location('main.php?page=service')</script>";
        }
        
    } else {
        echo "";
    }
  * 
  */
/*
function insertbooking($date, $spname, $service, $userid, $spId, $conn){
    $serviceid = "SELECT serviceId from service where servicetype=$service";
echo $date;
    $insertquery = "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (NULL, '$userid', '$spId', '$serviceid', 'pending', '$date 00:00:00', NULL, NULL)";

    $result = mysqli_query($conn, $insertquery) or die();
}*/
}

