<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1 class="center"><strong>T R A N S A C T I O N &nbsp; H I S T O R Y</strong></h1>

<?php 
    $transHist = getTransHist($conn, $userID);
    $transactionHist = [];
    
    while($rows = mysqli_fetch_assoc($transHist)){
        $dateTime = new DateTime($rows['timestamp']);
        $id = $rows['transactionId'];
        $transId = $rows['transactionId'];
        $info = array('month' => $dateTime->format('m'), 'day' => $dateTime->format('d'), 'year' => $dateTime->format('Y'), 'transactionId' => $transId);
        $transactionHist[] = $info;
    }
    
    //gets today's date
    $date = new DateTime('now');
?>
    <form method="post" action="">
        <select name="month">
            <option value="<?php echo $date->format('m') ?>"><?php echo $date->format('F') ?></option>
            <option disabled="disabled">------------</option>
            <?php 
            for($i = 1; $i <= 12; $i++){
                $monthName = DateTime::createFromFormat('m', $i)->format('F'); 
                echo "<option value='$i'>$monthName</option>";
            }
            ?>
        </select>
        <select name="year">
            <option value="<?php echo $date->format('Y') ?>"><?php echo $date->format('Y') ?></option>
            <option disabled="disabled">------------</option>
            <?php
            for($i = $date->format('Y'); $i > $date->format('Y')-10; $i--){
                if($i >= 2008){
                    echo "<option value='$i'>$i</option>";
                }
            }
            ?>
        </select>
        <button type="submit">Filter</button>
    </form>
<?php
    if(filter_input(INPUT_POST, 'month') == null){
        $month = $date->format('m');
        $year = $date->format('Y');
    } else {
        $month = filter_input(INPUT_POST, 'month');
        $year = filter_input(INPUT_POST, 'year');
    }

    //first day of the month
    $firstDay = mktime(0,0,0, intval($month),1,$year);

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
    $daysInMonth = cal_days_in_month(0, $date->format('m'), $date->format('Y'));
    
    //make cal table
?>
        <table border=1 style="float: left">
            <tr height="50px">
                <th colspan=7 style="text-align: center">
                    <?php 
                    echo "$monthName $year";
                    ?></th>
            </tr>
            <tr class="home-calendar" height="100px">
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
        if($date->format('d') == $i && $month == $date->format('m') && $year == $date->format('Y')){
            echo "<td style='background-color: #ff9b9b'>$i</span> </td>";
        } elseif (in_array($month,array_column($transactionHist, 'month')) && in_array($i,array_column($transactionHist, 'day')) && in_array($year,array_column($transactionHist, 'year'))) {
            for ($a = 0; $a < count($transactionHist); $a++){
                if($transactionHist[$a]['month'] == $month && $transactionHist[$a]['day'] == $i){
                    $key = $transactionHist[$a]['transactionId'];
                }
            }
            
            echo <<<frag
                <td style='background-color: yellow'>$i 
                    <form method="post" action="">
                        <input type="hidden" name="transId" value="$key">    
                        <input type="hidden" name="month" value="$month">
                        <input type="hidden" name="day" value="$i">
                        <input type="hidden" name="year" value="$year">
                        <input class="btn btn-default" type="submit" value="More details"/>
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
    
require 'transactionHist.php';