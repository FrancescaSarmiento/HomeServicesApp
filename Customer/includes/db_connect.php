<?php

define('DBHOST', 'localhost');
define('DBUSER', 'root');
define('DBPASS', '');
define('DBNAME', 'handyzebdb');

$conn = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);

if(!$conn){
    die("Could not connect to database");
}