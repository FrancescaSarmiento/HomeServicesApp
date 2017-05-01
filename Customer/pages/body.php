<?php
include '../php/db_connection.php';
include '../php/functions.php';

if (!loggedin($user)){
    echo "<script>alert('Please log in');</script>";
    echo "<script>window.location.assign('login.php');</script>";
}

include '../pages/nav.php';
include '../pages/footer.php';