<?php
require 'db_connect.php';
if(!empty(filter_input(INPUT_POST, 'bookD'))){
    $bookdate = filter_input(INPUT_POST, 'bookD');
    $service = filter_input(INPUT_POST, 'sType');
    $userID = filter_input(INPUT_POST, 'user');
    $spId = filter_input(INPUT_POST, 'spId');
    $bookdate = $bookdate . " 00:00:00";
    $null = null;
    $pending='pending';
    $serviceid = "SELECT serviceId from service where servicetype='$service';";
        $serviceidresult=mysqli_query($conn, $serviceid) or die();
        $s = mysqli_fetch_assoc($serviceidresult);
    $sid = $s['serviceId'];
    $insertquery = mysqli_prepare($conn, "INSERT INTO booking (custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $insertquery->bind_param('issssss',$userID, $spId, $sid, $pending, $bookdate, $null, $null);
    $insertquery->execute();
    $error = $insertquery->error;
    
        echo "<script>alert('Booking request was sent to the service provider. You will be notified once the service provider responded to your request. Thank you.');"
        . "window.location.assign('../pages/main.php?page=services');</script>";
        echo 's?';
}