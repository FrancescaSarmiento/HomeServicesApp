<?php 
include 'db_connect.php';
if(filter_input(INPUT_POST, 'bookingId')){
    $bookingId = filter_input(INPUT_POST, 'bookingId');

    $query = mysqli_prepare($conn, "UPDATE booking SET bookingStatus = 'cancelled' WHERE bookingId = ?");
    $query->bind_param('i', $bookingId);
    $query->execute();
    $result = $query->get_result();
    
    $get = mysqli_prepare($conn, "select * from sp_service join booking using(serviceId) where bookingId = ?");
    $get->bind_param('i', $bookingId);
    $get->execute();
    $res = $get->get_result();
    
    $row = mysqli_fetch_assoc($res);
    $penalty = $row['fixedRate'] * .10;
    
    $balance = mysqli_prepare($conn, "update user join customer on user.idNum = customer.custId join booking using(custId) SET balance = ? where bookingId = ?");
    $balance->bind_param('di',$penalty, $bookingId);
    $balance->execute();
    
    header('Location: ../pages/main.php?page=home');
    mysqli_close($conn);
}