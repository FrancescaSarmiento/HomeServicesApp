<?php
session_unset();

if (empty($_SESSION)){
    echo "<script>alert('You have successfully logged out')</script>";
    echo "<script>window.location.assign('../pages/login.php');</script>";
}