<?php
require '../includes/blockedPages.php';

$query = "SELECT serviceType from service";
$result = mysqli_query($conn, $query);
?>

		<h1><strong> Services </strong></h1>
	
<?php

        while($row = mysqli_fetch_assoc($result)){
	       foreach($row as $key => $value){
                    echo <<<frag
                        <form method="post" action="">
                            <input type="hidden" name="type" value="$value">
                            <input class="btn btn-link" type="submit" name="submit" value="$value">
                        </form>
frag;
   //<a href='?page=services&type=$value'> $value </a><br>";
                  break;
	       }
        }         
require 'spService.php';