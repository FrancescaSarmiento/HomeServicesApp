<html>
	<head>
	<style>
		a{ text-decoration: none; font-size: 30px;}
		a:hover{ font-weight: bold; }</style>
	</head>
	<body>

<?php
include '../includes/blockedPages.php';
include '../includes/functions.php';

$query = "SELECT serviceType from service";
$result = mysqli_query($conn, $query);
?>

		<h1> Services </h1>
	
<?php

        while($row = mysqli_fetch_assoc($result)){
	       foreach($row as $key => $value){
		  echo "<a href='spservice.php?type=$value'> $value </a><br>";
	       }
        }         
?>
        
	<br><hr>
	</body>
</html>