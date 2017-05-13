<?php 
include 'db_connect.php';
if(filter_input(INPUT_POST, 'transid')){
    $id = filter_input(INPUT_POST, 'transid');
    $query = mysqli_prepare($conn, "UPDATE transaction SET custStatus = 'approved' WHERE transactionId = ?");
    $query->bind_param('i', $id);
    $query->execute();
    
    header('Location: ../pages/main.php?page=home');
    mysqli_close($conn);
} else {
    echo "hello";
}