<?php

if(isset($_GET['spid'])){
    $spId = $_GET['spid'];
    getUserProfile($spId, $conn);
}