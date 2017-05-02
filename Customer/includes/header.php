<?php 

    require 'functions.php';
    $url = explode('/',filter_input(INPUT_SERVER, 'REQUEST_URI'),5);
    $title = $url[3];
    
?>

<!DOCTYPE html>
<html>
    <head>
        <title><?php getTitle($title); ?></title>
    </head>
<body>