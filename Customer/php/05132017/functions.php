<?php

/*function insertbooking($date, $spname, $service, $userid, $spId, $conn){
	$serviceid = "SELECT serviceId from service where servicetype=$service";
	$insertquery = "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (NULL, '$userid', '$spId', '$serviceid', 'pending', '$date 00:00:00', NULL, NULL)";
	$result = mysqli_query($conn, $insertquery) or die();
}

function queryAvailableSP(){
    $servicessp = "SELECT DISTINCT name, spId, working_days, availability from (SELECT concat(firstName,' ', lastName) as name, spId, working_days, availability from service_provider join sp_service using(spId) join service using(serviceId) where serviceType='$servtype') as sps where spId NOT IN(SELECT spId FROM `booking` join service_provider  using(spId) where reserved_date like '{$availday} %' and bookingStatus != 'done') AND (working_days like '%{$dayOfWeek}%' OR availability='1')";
    $result = mysqli_query($conn, $servicessp);
}*/

function insertBooking($service, $userID, $spId,$bookdate, $conn){

    $bookdate = $bookdate . " 00:00:00";
    $null = null;
    $pending='pending';
    $serviceid = "SELECT serviceId from service where servicetype='$service';";
        $serviceidresult=mysqli_query($conn, $serviceid) or die();
        $s = mysqli_fetch_assoc($serviceidresult);
    $sid = $s['serviceId'];
    $insertquery = "INSERT INTO booking (bookingId, custId, spId, serviceId, bookingStatus, reserved_date, dateStarted, dateFinished) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_stmt_init($conn);
    
    mysqli_stmt_prepare($stmt, $insertquery);
    
    $prep_stmt = mysqli_stmt_bind_param($stmt, 'ssssssss',$null, $userID, $spId, $sid, $pending, $bookdate, $null, $null);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
    return;
}

function getUserProfile($spId, $conn){
    $query1 = "SELECT spId, firstName, lastName, avg(rating) as rating from service_provider join feedback using(spId) group by 1, 2, 3";
    $result1 = mysqli_query($conn, $query1) or die(mysqli_error($conn));
    $query2 = "SELECT concat(firstName,' ',lastName) as name, servicetype from service_provider join sp_service using(spId) join service using(serviceId) where spId=$spId";
    $result2 = mysqli_query($conn, $query2) or die(mysqli_error($conn));

    while($row = mysqli_fetch_assoc($result1)){
        echo <<<sp
        <div>
            <p> {$row['firstName']} {$row['lastName']}
            </p>
            <p> Rating: {$row['rating']}</p>
        </div>

sp;
    }
}

function checkCurrentMessages($conn, $userID){
    $query = "SELECT DISTINCT sp.spId, sp.firstName, sp.lastName from message m join customer c on m.senderId = c.custId join service_provider sp on m.receiverId= sp.spId WHERE c.custId='$userID'";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    $row = mysqli_num_rows($result);

    if($row > 0 ){
        while($rows = mysqli_fetch_assoc($result)){
            echo <<<senders
            <a href="main.php?page=messages&id={$rows['spId']}">
                <li>{$rows['firstName']} {$rows['lastName']}</li>
            </a>
senders;
        }
    }
    
    mysqli_free_result($result);
}

function getMessages($conn, $spId, $userId){
    $query = "SELECT * from message order by timeSent";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    while ($rows = mysqli_fetch_assoc($result)){    
        if($rows['receiverId'] == $spId && $rows['senderId'] == $userId){
            echo "<p class='chat right'>{$rows['messageBody']}</p>";
            echo "<div class='space'></div>";        
        } elseif ($rows['senderId'] == $spId && $rows['receiverId'] == $userId ) {
            
            echo "<p class='chat left'>{$rows['messageBody']}</p>";    
            echo "<div class='space'></div>";   
        }
    }
    
    mysqli_free_result($result);
}

function reply($conn, $userID, $spID, $message){
    $ct = date('Y-m-d H:i:s');
    $query = "INSERT INTO message (senderId, receiverId, messageBody, timeSent) VALUES ('$userID','$spID','$message','$ct')";
    mysqli_query($conn, $query) or die(mysqli_error($conn));
}

function getAcctInfo($conn, $userID){
    $query = "SELECT * from user u join customer c on u.idNum = c.custId WHERE idNum = $userID";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getTransHist($conn, $userId){
    $query = "SELECT transactionId, sp.firstName, sp.lastName, timestamp, specification FROM transaction t join customer c USING(custId) join service_provider sp USING(spId) join booking b USING(bookingId) WHERE c.custId = $userId";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getService($conn){
    $query = "SELECT serviceType from service";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getServiceProviders($conn, $servtype){
    $query = "SELECT DISTINCT serviceType, concat(firstName,' ', lastName) as name from service_provider join sp_service using(spId) join service using(serviceId) where serviceType='$servtype'";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getBooking($conn, $userId){
    $query = "SELECT * from booking where custId = $userId and (bookingStatus = 'pending' or bookingStatus = 'ongoing')";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    $row = mysqli_num_rows($result);
    if($row > 0){
        echo "<h2>Your current bookings:</h2>";
        return $result;
    } else {
        echo "<h2>No current bookings atm</h2>";
        return null;
    }
}

function getBookingDetails($conn, $bookingId){
    $query = "SELECT * from booking join service_provider using(spId) join service using(serviceId) where bookingId = $bookingId";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    while ($rows = mysqli_fetch_assoc($result)){
        $status = ucfirst($rows['bookingStatus']);
        require_once 'cancel.php';
        echo <<<frag
        <div id="bookingDetails" style="float: right;">
            <p>Service Provider: {$rows['firstName']} {$rows['lastName']}</p>
            <p>Service Type: {$rows['serviceType']}</p>
            <p>Status: $status</p>
frag;
        if ($status !== 'Ongoing'){
        echo <<<frag
            <form action="" method="post">    
                <button class="btn btn-primary" name="submit" type="submit" value="{$rows['bookingId']}" onclick="return confirm('Are you sure you want to cancel?')">Cancel booking</button>
            </form>
        </div>
frag;
        } else {
            $dateTime = new DateTime($rows['dateStarted']);
            echo "<p>Time started: {$dateTime->format('h:i')}";
            if($dateTime->format('h') >= 12){
                echo " PM";
            } else {
                echo " AM";
            }
            echo "</p>";
        }
    }
    mysqli_free_result($result);
}