<?php
require '../includes/blockedPages.php';

$query = "SELECT serviceType from service";
$result = mysqli_query($conn, $query);
?>

		<h1> Services </h1>
	
<?php

        while($row = mysqli_fetch_assoc($result)){
	       foreach($row as $key => $value){
		  echo "<a href='?page=services&type=$value'> $value </a><br>";
                  break;
	       }
        }         
require 'spService.php';