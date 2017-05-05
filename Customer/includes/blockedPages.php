<?php 
    
    $url = filter_input(INPUT_SERVER, 'REQUEST_URI');
    $slash = strval(explode('/',$url,3)[2]);
    
    if(!strpos($slash, '?')){
        if (!strpos($splash, '&')) {
            if ($slash != 'login.php'){
               echo "<script>alert('Please log in');window.location.assign('../login.php')</script>";
            }
        }
    }