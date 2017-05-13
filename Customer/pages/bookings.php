<?php

if(filter_input(INPUT_POST, 'id') !== null){
    $month = filter_input(INPUT_POST, 'month');
    $day = filter_input(INPUT_POST, 'id');
    
    $query = mysqli_prepare($conn, "SELECT * from booking join service_provider using(spId) join service using(serviceId) where custId = ?");
    $query->bind_param('s', $userID);
    $query->execute();
    $result = $query->get_result();

    while ($rows = $result->fetch_assoc()){
        $mD = new DateTime($rows['reserved_date']);
    if ($mD->format('m') == $month){
        if($mD->format('d') == $day){
            $status = ucfirst($rows['bookingStatus']);

            echo <<<frag
                <div id="bookingDetails" style="float: right; margin-right: 5%;">
                    <div style='border-top: solid;'></div>
                    <p>Service Provider: {$rows['firstName']} {$rows['lastName']}</p>
                    <p>Service Type: {$rows['serviceType']}</p>
                    <p>Status: $status</p>
frag;
                if ($status == 'Pending'){
                    echo <<<frag
                        <form action="../includes/cancel.php" method="post"  onclick="return confirm('Are you sure? You will be penalized 10% of the booking request made for cancellation');" >    
                            <input type="hidden" name="bookingId" value="{$rows['bookingId']}">
                            <input class="btn btn-primary" type="submit" value="Cancel"</input>
                        </form>
                    </div>
frag;
                
                } else {
                    $dateTime = new DateTime($rows['dateStarted']);
                    echo "<p>Time started: {$dateTime->format('h:i a')}</p>";
                }
            }
            
        }
    }
    
    $result->free_result();
}