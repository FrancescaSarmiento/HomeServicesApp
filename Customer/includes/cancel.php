<?php 

if(filter_input(INPUT_POST, 'submit')){
    $bookingId = filter_input(INPUT_POST, 'submit');
    $query = "UPDATE booking SET bookingStatus = 'cancelled' WHERE bookingId=$bookingId";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    
    header('Location: ../pages/main.php?page=home');
    mysqli_close($conn);
}