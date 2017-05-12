<html>
    <head>   
        <link href="../css/calendar.css" type="text/css" rel="stylesheet" />
    </head>
<body>

<?php

require 'db_connection.php';
include 'calendar.php';

$availday = isset($_GET['dayis'])? $_GET['dayis'] : null;
$dayExtract = strtotime($availday);
$dayOfWeek = date('D', $dayExtract);
$servtype = $_GET['type'];
	global $conn;
	$service = mysqli_real_escape_string($conn, $servtype);
	$servicessp = "SELECT DISTINCT name, spId, working_days, availability from (SELECT concat(firstName,' ', lastName) as name, spId, working_days, availability from service_provider join sp_service using(spId) join service using(serviceId) where serviceType='$servtype') as sps where spId NOT IN(SELECT spId FROM `booking` join service_provider  using(spId) where reserved_date like '{$availday} %' and bookingStatus != 'done') AND working_days like '%{$dayOfWeek}%' AND availability='1'";
	$result = mysqli_query($conn, $servicessp);
    
echo "Choose a date from the calendar to show available service providers.";
$calendar = new Calendar();
echo $calendar->show();

if (mysqli_num_rows($result)>0 && $availday != null){ ?>
	<h2> Available service providers for <span style="color:red"><?php echo $servtype ?></span> service </h2>
    <?php
    while($row = $result->fetch_assoc()){
			echo '<br>' . $row["name"] . '&nbsp <a href="#">Book Now </a><br>';
    } 
} else if ($availday == null){echo "";
} else {
            echo "Sorry, no available service provider for this date.<br> Please choose another date.";
        }

?>