<?php

function checkCurrentMessages($conn, $userID){
    $query = mysqli_prepare($conn,"SELECT DISTINCT sp.spId, sp.firstName, sp.lastName from message m join customer c on m.senderId = c.custId join service_provider sp on m.receiverId= sp.spId WHERE c.custId=?");
    $query->bind_param('i', $userID);
    $query->execute();
    $result = $query->get_result();
    $row = mysqli_num_rows($result);

    if($row > 0 ){
        while($rows = mysqli_fetch_assoc($result)){
            echo <<<senders
            <form method="post" action="">
                <input type="hidden" value="{$rows['spId']}" name='spId'>
                <input type="submit" name='submit' value='{$rows['firstName']} {$rows['lastName']}' class="btn btn-link">
            </form>
senders;
        }
    }
    
    mysqli_free_result($result);
}

function getMessages($conn, $spId, $userId){
    $query = mysqli_prepare($conn, "SELECT * from message order by timeSent");
    $query->execute();
    $result = $query->get_result();
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

function reply($conn, $userID, $spID, $messageBody){
    $ct = date('Y-m-d H:i:s');
    $message = htmlspecialchars($messageBody);
    $query = mysqli_prepare($conn, "INSERT INTO message (senderId, receiverId, messageBody, timeSent) VALUES (?,?,?,?)");
    $query->bind_param('iiss', $userID,$spID,$message,$ct);
    $query->execute();
}

function getAcctInfo($conn, $userID){
    $query = "SELECT * from user u join customer c on u.idNum = c.custId WHERE idNum = $userID";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getTransHist($conn, $userId){
    $stmt = "select transactionId, timestamp from transaction t join booking b using(bookingId) join service_provider sp using(spId) where custId = ?";
    $query = mysqli_prepare($conn, $stmt);
    $query->bind_param('s', $userId);
    $query->execute();
    $result = $query->get_result();
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
    $query = mysqli_prepare($conn, "SELECT * from booking where (bookingStatus = 'pending' or bookingStatus = 'ongoing') and custId = ? and (reserved_date > CURRENT_DATE or reserved_date = CURRENT_DATE)");
    $query->bind_param('s',$userId);
    $query->execute();
    $result = $query->get_result();
    $row = mysqli_num_rows($result);
    if($row > 0){
        echo "<h2>Your current bookings:</h2>";
        return $result;
    } else {
        echo "<h2>No current bookings atm</h2>";
        return false;
    }
}

function getNotifs($conn, $userID){
    $query = mysqli_prepare($conn, "SELECT * from booking join service_provider using(spId) where (bookingStatus = 'accepted' or bookingStatus = 'rejected') and custId = ? order by notifTimestamp desc limit 5");

    $query->bind_param('s', $userID);
    $query->execute();

    $result = $query->get_result();

    $date = new DateTime("now");
    if($result){
        while ($rows = mysqli_fetch_assoc($result)){
        $fName = $rows['firstName'];
        $lName = $rows['lastName'];
        $status = $rows['bookingStatus'];
        $timestamp = date_create($rows['notifTimestamp']);
        $ago = date_diff($timestamp, $date);

        echo <<<frag
            <li class="notification">
                <div class="media-body">
                    <strong class="notification-title">$fName $lName</strong>
                    <span class="notification-desc">has $status your service request</span>

                    <div class="notification-meta">
                        <small class="timestamp">
frag;
                    if($ago->d > 0 and $ago->d == 1){
                        echo "$ago->d day ago";
                    } elseif ($ago->d > 1){
                        echo "$ago->d days ago";
                    } elseif ($ago->h > 0 and $ago->h == 1){
                        echo "$ago->h hour ago";
                    } elseif ($ago->h > 1){
                        echo "$ago->h hours ago";
                    } elseif ($ago->i > 0 and $ago->i == 1){
                        echo "$ago->i minute ago";
                    } elseif ($ago->i > 1){
                        echo "$ago->i minutes ago";
                    }
        echo <<<frag
            </small>
                    </div>
                </div>   
            </li>
frag;
        }
    }else {
        echo "<li class='notification'><div class='media-body'><strong clas='notification-title'>You have no notifications</strong></div></li>";
    }
}

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

function getConfirm($conn, $userId){
    $query = mysqli_prepare($conn, "select * from transaction t join booking b using(bookingId) join service_provider sp using(spId) join service using(serviceId) where custId = ? and custStatus = 'pending'");
    $query->bind_param('i', $userId);
    $query->execute();
    $result = $query->get_result();
    if(!empty($result)){
        echo "<h2>Transactions that needs confirmation:</h2>";
        return $result;
    } else {
        return false;
    }
}