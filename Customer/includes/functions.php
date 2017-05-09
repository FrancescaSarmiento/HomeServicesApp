<?php

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
        return false;
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