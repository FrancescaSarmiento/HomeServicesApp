<?php 

    $requestURI = filter_input(INPUT_SERVER, 'REQUEST_URI');
    $queryString = filter_input(INPUT_SERVER, 'QUERY_STRING');
    
    if(empty($queryString)){
        $split = strval(explode('.',explode('/', $requestURI, 4)[1],3)[0]);
    } else {
        $split = strval(explode('&',explode('=', $queryString,3)[1],2)[0]);
    }
    
?>

<!DOCTYPE html>
<html>
    <head>
        <title><?php echo ucwords($split); ?></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/calendar.css">
        <link rel="stylesheet" href="../css/bootstrap-notifications.css">
        <link rel="stylesheet" href="../css/bootstrap-notifications.min.css">
    </head>
<body>