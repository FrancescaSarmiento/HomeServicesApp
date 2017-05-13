<?php
require 'db_connect.php';

$searchInput = filter_input(INPUT_GET, 'search');

$searchInput = mysqli_escape_string($conn, $searchInput);

$query = mysqli_prepare($conn, "SELECT t1.firstName, t1.lastName, t2.firstName, t2.lastName from message m left join service_provider t1 on m.senderId = t1.spId left join service_provider t2 on m.receiverId = t2.spId where (t1.firstName like ? or t2.firstName like ?) or (t1.lastName like ? or t2.lastName like ?)");

var_dump($query);
var_dump(preg_match('/\s/', $searchInput));
if (preg_match('/\s/', $searchInput) == 0){    
    $query->bind_param(':term:term:term:term', "$searchInput%","$searchInput%","$searchInput%","$searchInput%");

    var_dump($query);
} elseif (preg_match('/\s/', $searchInput) == 1) {
    $inputs = explode(" ", $searchInput);
    $query->bind_param('ssss',$inputs[0], $inputs[1],$inputs[0],$inputs[1]);
}

$query->execute();
$result = $query->get_result();
var_dump($result);