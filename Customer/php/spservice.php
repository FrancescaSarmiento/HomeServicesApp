<?php

require 'php/db_connection.php';
session_start();
include 'service.php';
$servtype = $_GET['value'];

	global $conn;
	$service = mysqli_real_escape_string($conn, $servtype);
	$query = "SELECT DISTINCT serviceType, concat(firstName,' ', lastName) as name from service_provider join sp_service using(spNumber) join service using(serviceNumber) where serviceType='$servtype'";
	$result = mysqli_query($conn, $query);
?>

	<h1> Service Provider for <?php echo $servtype ?> service </h1>

	<?php 
	while($row = $result->fetch_assoc()){
		echo $row["name"] . '<br>';
	} $result -> free();
	?>
