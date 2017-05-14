<?php
require_once 'db_connect.php';

if(!empty(filter_input(INPUT_POST, 'submit'))){
    $id = filter_input(INPUT_POST, 'id');
    $currentPass = filter_input(INPUT_POST, 'currentPass');
    $newPass = filter_input(INPUT_POST, 'newPass');
    $confirmPass = filter_input(INPUT_POST, 'confirmPass');

    $query = mysqli_prepare($conn, "Select * from user join customer on user.idNum = customer.custId where custId = ?");
    $query->bind_param('i', $id);
    $query->execute();
    $result = $query->get_result();
    $rows = mysqli_fetch_assoc($result);

    if($rows['custId'] == $id){
        if($rows['password'] == $currentPass){
            if($newPass == $confirmPass){
                $newP = mysqli_prepare($conn, "update user join customer on user.idNum = customer.custId set password = ? where custId = ?");
                $newP->bind_param('si', $newPass, $id);
                $newP->execute();
                
                echo '<div class="alert alert-success">Successfully changed password</div>';
                $newP->free_result();

            } else {
                echo '<div class="alert alert-danger">New password does not match</div>';
            }
        } else {
            echo '<div class="alert alert-danger">Incorrect current password</div>';
        }
    }
    
    $result->free_result();
}