<?php 
    include '../includes/blockedPages.php';
    include '../includes/functions.php';
?>

<h1>Services</h1>

<?php 
    $services = getService($conn);
    
    //prints services
    while($row = mysqli_fetch_assoc($services)){
	foreach($row as $key => $value){
		echo "<a href='?page=services&value=$value'> $value </a><br>";
	}
    }    
    //outputs service providers
    $servtype = filter_input(INPUT_GET, 'value');
    $sp = getServiceProviders($conn, $servtype);
?>

    	<h1> Service Provider for <?php echo $servtype ?> service </h1>

<?php
    while($row = mysqli_fetch_assoc($sp)){
        echo $row["name"] . '<br>';
    }
    mysqli_free_result($sp);
	