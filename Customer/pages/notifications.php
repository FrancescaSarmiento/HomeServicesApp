<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Notifications</h1>
<?php
$notifs = getNotifs($conn, $userID);