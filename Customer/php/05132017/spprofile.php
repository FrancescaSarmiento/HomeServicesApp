<?php
require '../includes/db_connect.php';
require '../includes/functions.php';
    ?>

<html>
<body>



<?php

$spId = $_GET['spid'];
$service = $_GET['type'];
getUserProfile($spId, $service, $conn);
?>

</body>
</html>