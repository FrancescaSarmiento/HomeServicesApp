<?php
require 'db_connect.php';
if(!empty(filter_input(INPUT_POST, 'bookdate'))){
    $bookdate = filter_input(INPUT_POST, 'bookdate');
    $service = filter_input(INPUT_POST, 'service');
    $bookdate = $bookdate . " 00:00:00";
    $null = null;
    $pending='pending';
    $serviceid = "SELECT serviceId from service where servicetype='$service';";
        $serviceidresult=mysqli_query($conn, $serviceid) or die();
        $s = mysqli_fetch_assoc($serviceidresult);
    $sid = $s['serviceId'];
    $insertquery = mysqli_prepare($conn, "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $insertquery->bind_param('ssssssss',$null, $userID, $spId, $sid, $pending, $bookdate, $null, $null);
    $insertquery->execute();
    $res = $insertquery->get_result();

    echo "<script>alert('Booking request was sent to the service provider. You will be notified once the service provider responded to your request. Thank you.');"
    . "window.location.assign('../pages/main.php?page=services');</script>";
}