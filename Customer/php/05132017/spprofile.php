<?php
require '../includes/db_connect.php';
require '../includes/functions.php';
    ?>

<html>
<body>



<?php

$spId = $_GET['spid'];
getUserProfile($spId, $conn);
?>

</body>
</html>