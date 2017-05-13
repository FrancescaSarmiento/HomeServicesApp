<?php 
include 'db_connect.php';
if(filter_input(INPUT_POST, 'bookingId')){
    $bookingId = filter_input(INPUT_POST, 'bookingId');
    $query = "UPDATE booking SET bookingStatus = 'cancelled' WHERE bookingId=$bookingId";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    
    header('Location: ../pages/main.php?page=home');
    mysqli_close($conn);
}