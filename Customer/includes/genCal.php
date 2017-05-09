<?php

    $month = date('m', strtotime(filter_input(INPUT_GET, 'month')));
    $year = filter_input(INPUT_GET, 'year');
    
    header('Location: ../pages/main.php?page=transHist&month='.$month.'&year='.$year.'');