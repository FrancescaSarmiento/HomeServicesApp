<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Transaction History</h1>
<?php $transHist =  getTransHist($conn, $userID) ?>
<table>
    <tr>
        <th>Transaction ID</th>
        <th>Transaction Details</th>
        <th>Amount</th>
        <th>Date Start</th>
        <th>Date Finish</th>
        <th>Service Provider</th>
    </tr>
        <?php
            while($row = mysqli_fetch_array($transHist, MYSQLI_ASSOC)){
                $transId = $row['transactionId'];
                $dateStart = $row['date_started'];
                $dateFinish = $row['date_finished'];
                $spFName = $row['firstName'];
                $spLName = $row['lastName'];
                $specifications = $row['specification'];
                var_dump($specifications);
                $divide = explode(';',$specifications);
                var_dump($divide);
                $split = explode(',',$divide[0]);
                var_dump($split);
                
                echo <<<acctInfo
                <tr>
                    <td>$transId</td>
acctInfo;
                for($i = 0; $i < count($row['specification']); $i++){
                echo <<<details
                    <td></td>
                    <td></td>
details;
                }

                echo <<<acctInfo
                    <td>$dateStart</td>
                    <td>$dateFinish</td>
                    <td>$spFName $spLName</td>
acctInfo;
            }
        ?>
    </tr>
</table>