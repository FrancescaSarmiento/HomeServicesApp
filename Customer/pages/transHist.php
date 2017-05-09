<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Transaction History</h1>

<?php 
    $transHist = getTransHist($conn, $userID);
    $transactionHist = [];
    
    while($rows = mysqli_fetch_assoc($transHist)){
        $dateTime = new DateTime($rows['timestamp']);
        $id = $rows['transactionId'];
        $transactionHist[$id] = array('month' => $dateTime->format('m'), 'day' => $dateTime->format('d'), 'year' => $dateTime->format('Y'));
    }
    
    var_dump($transactionHist);
    //gets today's date
    $date = time();
?>
    <form method="get" action="../includes/genCal.php">
        <select name="month">
            <option value="<?php echo date('m',$date) ?>"><?php echo date('F',$date) ?></option>
            <option disabled="disabled">------------</option>
            <?php 
            for($i = 1; $i <= 12; $i++){
                $monthName = DateTime::createFromFormat('m', $i)->format('F'); 
                echo "<option>$monthName</option>";
            }
            ?>
        </select>
        <select name="year">
            <option value="<?php echo date('Y',$date) ?>"><?php echo date('Y',$date) ?></option>
            <option disabled="disabled">------------</option>
            <?php
            for($i = date('Y',$date); $i > date('Y',$date)-10; $i--){
                if($i >= 2008){
                    echo "<option>$i</option>";
                }
            }
            ?>
        </select>
        <button type="submit">Filter</button>
    </form>
<?php
    if(filter_input(INPUT_GET, 'month') == null){
        $month = date('m',$date);
        $year = date('Y',$date);
    } else {
        $month = filter_input(INPUT_GET, 'month');
        $year = filter_input(INPUT_GET, 'year');
    }

    //first day of the month
    $firstDay = mktime(0,0,0, $month,1,$year);

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
    $daysInMonth = cal_days_in_month(0, date('m',$date), date('Y',$date));
    
    //make cal table
?>
        <table border=1 style="float: left">
            <tr height="50px">
                <th></th>
                <th colspan=5 style="text-align: center">
                    <?php  
                    $mName = date('F', mktime(0, 0, 0, $month, 1,0));
                    $yName = date('Y', mktime(0, 0, 0, 0, 0, $year+1));
                    echo "$mName $yName";
                    ?></th>
                <th></th>
            </tr>
            <tr style="background-color: lightblue; text-align: center;" height="100px">
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
        if(date('d', $date) == $i && $month == date('m',$date)){
            echo "<td style='background-color: #ff9b9b'><span class='calNum'>$i</span> </td>";
        } elseif($month == $transactionHist[3]['month'] && in_array($i, $transactionHist)){
            $key = array_search($i, $transactionHist);
            echo "<td style='background-color: yellow'>$i <a class='btn btn-default' href='?page=home&value=current&id=$key'>Booking Details</a></td>";
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
        getTransactionDetails($conn, filter_input(INPUT_GET, 'id'));
    }