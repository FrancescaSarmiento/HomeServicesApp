<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Welcome <?php echo "{$_SESSION['firstName']}  {$_SESSION['lastName']}" ?>!</h1>

<?php 
    $bookings = getBooking($conn, $userID);
    $currentMonthBookings = [];
    $nextMonthBookings = [];
    //gets today's date
    $date = time();
 
    $day = date('d',$date);
    $month = date('m',$date);
    $year = date('Y',$date);
    
    while($rows = mysqli_fetch_assoc($bookings)){
        $dateTime = new DateTime($rows['reserved_date']);
        if($dateTime->format('m') == $month){
            $id = $rows['bookingId'];
            $currentMonthBookings[$id] = $dateTime->format('d');
        } elseif ($dateTime->format('m') > $month ){
            $id = $rows['bookingId'];
            $nextMonthBookings[$id] = $dateTime->format('d');
        }
    }
    
    if(filter_input(INPUT_GET, 'value') == "current"){
        $month;
    } elseif (filter_input(INPUT_GET, 'value') == "next"){
        $month++;
    }
    
    
    //first day of the month
    $firstDay = mktime(0,0,0,$month,1,$year);

    //month name
    $monthName = date('F', $firstDay);
    
    //day of the week, first day of the month
    $dayOfWeek = date('D', $firstDay);
    
    switch($dayOfWeek){
        case "Sun":
            $start = 0;
            break;
        case "Mon":
            $start = 1;
            break;
        case "Tue":
            $start = 2;
            break;
        case "Wed":
            $start = 3;
            break;
        case "Thu":
            $start = 4;
            break;
        case "Fri":
            $start = 5;
            break;
        case "Sat":
            $start = 6;
    }
    
    //determine how many days in current month
    $daysInMonth = cal_days_in_month(0, $month, $year);
    
    //make cal table
?>
        <table border=1 id="left-side">
            <tr height="50px">
                <th class="center">
                    <?php 
                        if (!filter_input(INPUT_GET, 'value') == null && filter_input(INPUT_GET, 'value') !== 'current'){
                        echo <<<frag
                            <a class="btn btn-default btn-sm" href="?page=home&value=current">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
frag;
                        }
                    ?>
                </th>
                <th colspan=5 class="center"><?php echo "$monthName $year" ?></th>
                <th class="center">
                    <?php 
                     //   var_dump(filter_input(INPUT_GET,'value'));
                        if (!isset($_GET['value']) || $_GET['value'] == 'current'){
                        echo <<<frag
                            <a class="btn btn-default btn-sm" href="?page=home&value=next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
frag;
                        }
                    ?>
                </th>
            </tr>
            <tr class="home-calendar" height=60px;>
                <td width = 110px>Sun</td>
                <td width = 110px>Mon</td>
                <td width = 110px>Tue</td>
                <td width = 110px>Wed</td>
                <td width = 110px>Thu</td>
                <td width = 110px>Fri</td>
                <td width = 110px>Sat</td>
            </tr>
            
<?php
    
    //count days in the week, up to 7
    $dayCount = 1;
    
    echo "<tr height = 100px>";
    
    //blank days before beginning of first month
    while ( $start > 0 ) { 
        echo "<td style='background-color: lightgrey'></td>"; 
        $start--; 
        $dayCount++;
    }
    
    //sets first day of the month to 1
    $dayNum = 1;
    
    //count up the days, until the end of month
    for ($i = $dayNum; $i <= $daysInMonth; $i++ ){
        if($day == $i && $month == date('m',$date)){
            echo "<td style='background-color: #ff9b9b'><span class='calNum'>$i</span> </td>";
        } elseif ($month == date('m',$date) && in_array($i, $currentMonthBookings)) {
            $key = array_search($i, $currentMonthBookings);
            echo "<td style='background-color: yellow'>$i <a class='btn btn-default' href='?page=home&value=current&id=$key'>Booking Details</a></td>";
        } elseif ($month !== date('m',$date) && in_array ($i, $nextMonthBookings)){
            $key = array_search($i, $nextMonthBookings);
            echo "<td style='background-color: yellow'>$i <a class='btn btn-default' href='?page=home&value=next&id=$key'>Booking Details</a></td>";
        } else {
            echo "<td>$i</td>"; 
        }

        $dayCount++;

        //start a new row every week
        if ($dayCount > 7){
            echo "</tr><tr height = 100px>";
            $dayCount = 1;
        }
    }
    
    while ($dayCount > 1 && $dayCount <= 7){
        echo "<td style='background-color: lightgrey'></td>";
        $dayCount++;
    }
    
    echo "</tr></table>";
    if(filter_input(INPUT_GET, 'id') !== null){
        getBookingDetails($conn, filter_input(INPUT_GET, 'id'));
    }