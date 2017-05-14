<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1 id="homeName"><strong>Welcome <?php echo "{$_SESSION['firstName']}  {$_SESSION['lastName']}" ?>!</strong></h1>

<?php
    $confirm = getConfirm($conn, $userID);
    
if(!empty($confirm)){
    
    while ($rows = $confirm->fetch_assoc()){
        $detail = mysqli_prepare($conn, "select * from paymentdetails join transaction using(transactionId) where transactionId = ?");
        $detail->bind_param('i', $rows['transactionId']);
        $detail->execute();
        $detailResult = $detail->get_result();
        
        $amt = mysqli_prepare($conn, "select sum(amount) as total from paymentdetails join transaction using(transactionId) where transactionId = ?");
        $amt->bind_param('i', $rows['transactionId']);
        $amt->execute();
        $total = $amt->get_result()->fetch_assoc();
        
        $mD = new DateTime($rows['timestamp']);
        $dateOfTrans = $mD->format('h:i a');
        $tranid = $rows['transactionId'];
                echo <<<frag
                    <div id="bookingDetails">
                        <div style='border-top: solid;'></div>
                        <p>Service Provider: {$rows['firstName']} {$rows['lastName']}</p>
                        <p>Service Type: {$rows['serviceType']}</p>
                        <p>Timestamp: $dateOfTrans</p>
                        <p>Transaction Details:
                            <table>
                                <tr>
                                    <th>Service Details:</th>
                                    <th>Amount (&#8369;)</th>
                                </tr>
frag;
                        
                while ($rR = $detailResult->fetch_assoc()){
                    echo "<tr>";
                    echo "<td>{$rR['serviceMade']}</td>";
                    echo "<td>{$rR['amount']}</td>";
                    echo "</tr>";
                }
                $row = $detailResult->fetch_assoc();
                echo <<<frag
                                <tr>
                                    <th>Total:</th>
                                    <td>{$total['total']}</td>
                                    
                            </table>
frag;
                echo <<<frag
                            <form action="../includes/confirm.php" method="post">
                                <input type="hidden" value="$tranid" name="transid">
                                <input class="btn btn-primary" type="submit" value="Confirm payment" name="confirm">
                            </form>
                        </p>
frag;
    }
}   
    $bookings = getBooking($conn, $userID);
if(!empty($bookings)){
    $currentbooking = [];
    $nextbooking = [];
    //gets today's date
    $date = time();
 
    $day = date('d',$date);
    $month = date('m',$date);
    $year = date('Y',$date);
    
    while($rows = mysqli_fetch_assoc($bookings)){
        $dateTime = new DateTime($rows['reserved_date']);
        $m = $dateTime->format('m');
        $d = $dateTime->format('d');
        if ($m == date('m',$date)){
            $currentbooking[] = array('month'=>$m, 'day'=>$d);
        } else {
            $nextbooking[] = array('month'=>$m, 'day'=>$d);
        }
    }
    
    if(filter_input(INPUT_GET, 'value') == "current"){
        $month;
    } elseif (filter_input(INPUT_GET, 'value') == "next"){
        $month+=1;
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
        if($day == $i && $month == date('m',$date) && in_array($i, array_column($currentbooking, 'day'))){
            echo <<<frag
                <td style='background-color: #ff9b9b'>$i
                    <form method="post" action="">
                        <input type="hidden" name="month" value="$month">
                        <input type="hidden" name="id" value="$i">      
                        <input class="btn btn-default" type="submit" value="Booking Details"/>
                    </form>
                </td>
frag;
        } elseif ($day == $i && $month == date('m',$date)) {
            echo "<td style='background-color: #ff9b9b'>$i </td>";    
        } elseif (in_array($i, array_column($currentbooking,'day')) && $month == date('m', $date)) {
            echo <<<frag
                <td style='background-color: yellow'>$i 
                    <form method="post" action="">
                        <input type="hidden" name="month" value="$month">
                        <input type="hidden" name="id" value="$i">      
                        <input class="btn btn-default" type="submit" value="Booking Details"/>
                    </form>
                </td>
frag;
        } elseif ($month !== date('m',$date) && in_array($i, array_column($nextbooking,'day'))){
            echo <<<frag
                <td style='background-color: yellow'>$i 
                    <form method="post" action="">
                        <input type="hidden" name="month" value="$month">
                        <input type="hidden" name="id" value="$i">      
                        <input class="btn btn-default" type="submit" value="Booking Details"/>
                    </form>
                </td>
frag;
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

require 'bookings.php';
}