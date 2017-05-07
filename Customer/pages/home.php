<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>WELCOME <?php echo $_SESSION['firstName'] ?></h1>

<?php 
    $bookings = getBooking($conn);
    
?>
<table>
    
    <tr>
        <td>Service Provider</td>
        <td>Service Type</td>
        <td>Status</td>
    </tr>
<?php
    if($bookings){
        while ($rows = mysqli_fetch_assoc($bookings)){
            $spFName = $rows['firstName'];
            $spLName = $rows['lastName'];
            $servType = $rows['serviceType'];
            $status = $rows['status'];
        echo <<<book
            <tr>
            <td>$spFName $spLName</td>
            <td>{$rows['lastName']}</td>
            <td>$status</td>
            </tr>
book;
        }
    }