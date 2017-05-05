<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Transaction History</h1>
<?php $transHist =  getTransHist($conn, $userID) ?>
<table>
    <tr>
        <td>Transaction Id</td>
        <td>Date Start</td>
        <td>Date Finish</td>
        <td>Service Provider</td>
    </tr>
        <?php
            while($row = mysqli_fetch_array($transHist, MYSQLI_ASSOC)){
                $transId = $row['transactionId'];
                $dateStart = $row['date_started'];
                $dateFinish = $row['date_finished'];
                $spFName = $row['firstName'];
                $spLName = $row['lastName'];
                echo <<<table
                <tr>
                    <td>$transId</td>
                    <td>$dateStart</td>
                    <td>$dateFinish</td>
                    <td>$spFName $spLName</td>
table;
            }
        ?>
    </tr>
</table>