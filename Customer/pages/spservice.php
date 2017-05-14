<?php

$availday = filter_input(INPUT_POST, 'dayis');
$dayExtract = strtotime($availday);
$dayOfWeek = date('D', $dayExtract);
$servtype = filter_input(INPUT_POST, 'type');
if(!empty($servtype)){
        require_once '../includes/calendar.php';
        $servtype = filter_input(INPUT_POST, 'type');
	$servicessp = "SELECT DISTINCT name, spId, working_days, availability from (SELECT concat(firstName,' ', lastName) as name, spId, working_days, availability from service_provider join sp_service using(spId) join service using(serviceId) where serviceType='$servtype') as sps where spId NOT IN(SELECT spId FROM `booking` join service_provider  using(spId) where reserved_date like '{$availday} %' and bookingStatus != 'done') AND (working_days like '%{$dayOfWeek}%' OR availability='1')";
	$result = mysqli_query($conn, $servicessp);
        if(empty(filter_input(INPUT_GET, 'year'))){
            echo "Choose a date from the calendar to show available service providers.";
            $calendar = new Calendar();
            echo $calendar->show();
        } else {
            echo "Choose a date from the calendar to show available service providers.";
            $calendar = new Calendar();
            echo $calendar->show();
        }
}

if (mysqli_num_rows($result)>0 && $availday != null){ ?>
	<h2> Available service providers for <span style="color:red"><?php echo $servtype ?></span> service </h2>
    <?php
    while($row = $result->fetch_assoc()){
            $sp=$row["name"];
            $spid=$row["spId"];
			echo <<<frag
                            <br>
                            <form action="" method="post">
                                <input type="hidden" name="spId" value="$spid">
                                <input type="hidden" name="type" value="$servtype">
                                <input class="btn-link" type="submit" name="spinfo" value='{$row['name']}'>
                            </form>
                            <form method="post">
                                <input type="hidden" name="bookdate" value="$availday">
                                <input type="hidden" name="sp" value="$sp">
                                <input type="hidden" name="type" value="$servtype">
                                <input type="hidden" name="spid" value="$spid">
                                <input class="btn-link" type="submit" name="book" value="Book Now">
                            </form>
frag;
 //<a href="?page=services&bookdate='.$availday.'&sp='.$sp.'&type='.$servtype.'&spid='.$spid.'">Book Now </a><br>';
    } 
} else if ($availday == null){echo "";
} else {
            echo "Sorry, no available service provider for this date.<br> Please choose another date.";
        }

require_once 'book.php';

if(!empty(filter_input(INPUT_POST, 'spId'))){
    $spId = filter_input(INPUT_POST, 'spId');
    $type = filter_input(INPUT_POST, 'type');
    getUserProfile($spId, $conn, $type);
}