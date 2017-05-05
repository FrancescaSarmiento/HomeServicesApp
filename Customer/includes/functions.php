<?php

function checkCurrentMessages($conn, $userID){
    $query = "SELECT DISTINCT sp.spId, sp.firstName, sp.lastName from message m join customer c on m.receiverId = c.custId join service_provider sp on m.senderId= sp.spId WHERE c.custId='$userID'";
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
        if($rows['receiverId'] == $spId){
            
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
    $query = "SELECT firstName, lastName, address, email, contactNumber, userType, userName from user u join customer c on u.idNum = c.custId WHERE idNum = $userID";
    $result = mysqli_query($conn, $query);
    return $result;
}

function getTransHist($conn, $userId){
    $query = "SELECT * FROM transaction t join customer c on t.customerId = c.custId join service_provider sp on t.spId = sp.spId WHERE c.custId = $userId order by date_finished desc";
    $result = mysqli_query($conn, $query);
    return $result;
}