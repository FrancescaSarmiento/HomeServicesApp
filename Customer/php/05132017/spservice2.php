<html>
    <head>   
        <link href="../css/calendar.css" type="text/css" rel="stylesheet" />
    </head>
<body>

<?php

require '../includes/db_connect.php';
include '../includes/calendar.php';
require '../includes/blockedPages.php';

// get method should be converted to post
#get reservation date
$availday = isset($_GET['dayis'])? $_GET['dayis'] : null;

#convert value of $availday from string to time
$dayExtract = strtotime($availday);

#extract the day from the date and convert it to week of the day
$dayOfWeek = date('D', $dayExtract);

#service type
$servtype = $_GET['type'];

	$servicessp = "SELECT DISTINCT name, spId, working_days, availability from (SELECT concat(firstName,' ', lastName) as name, spId, working_days, availability from service_provider join sp_service using(spId) join service using(serviceId) where serviceType='$servtype') as sps where spId NOT IN(SELECT spId FROM `booking` join service_provider  using(spId) where reserved_date like '{$availday} %' and bookingStatus != 'done') AND (working_days like '%{$dayOfWeek}%' OR availability='1')";
	$result = mysqli_query($conn, $servicessp);

echo "Choose a date from the calendar to show available service providers.";
$calendar = new Calendar();
echo $calendar->show();

if (mysqli_num_rows($result)>0 && $availday != null){ ?>
	<h2> Available service providers for <span style="color:red"><?php echo $servtype ?></span> service </h2>

    <?php
    while($row = $result->fetch_assoc()){
            $sp=$row["name"];
            $spid=$row["spId"];
            echo <<<spgen
            
            <a href="spprofile.php?spid='.$spid.'">  {$row["name"]}</a>

            <form action="book.php" method="post">
                <input type="hidden" name="bookdate" value="{'$availday'}">
                <input type="hidden" name="spname" value="{'$sp'}">
                <input type="hidden" name="service" value="{'$servtype'}">
                <input type="hidden" name="spid" value="{'spid'}">
                <button type="submit" name="book">Book Now</button>
            </form>
spgen;
#<a href="book.php?bookdate='.$availday.'&sp='.$sp.'&service='.$servtype.'&spid='.$spid.'">Book Now </a><br>';

    } 
} else if ($availday == null){echo "";
} else {
            echo "Sorry, no available service provider for this date.<br> Please choose another date.";
        }

?>