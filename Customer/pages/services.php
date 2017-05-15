<?php
require '../includes/blockedPages.php';

$query = "SELECT serviceType from service";
$result = mysqli_query($conn, $query);
?>

		<h1 class="center"><strong> S E R V I C E S </strong></h1>
	
<?php
        echo "<table style='background-color:#f0e044'>";
        echo "<tr style='font-size:35px'>";
        while($row = mysqli_fetch_assoc($result)){
	       foreach($row as $key => $value){
                    echo <<<frag
                        <td style='width:16%'><form method="post" action="">
                            <input type="hidden" name="type" value="$value">
                            <input class="btn btn-link" type="submit" name="submit" value="$value">
                        </form></td>
frag;
   //<a href='?page=services&type=$value'> $value </a><br>";
                  break;
	       }
        }         
require 'spService.php';