<?php

if(filter_input(INPUT_POST, 'transId') !== null){
    $id = filter_input(INPUT_POST, 'transId');
    $month = filter_input(INPUT_POST, 'month');
    $day = filter_input(INPUT_POST, 'day');
    
    $query = mysqli_prepare($conn, "select firstName, lastName, timestamp, serviceType from transaction join booking using(bookingId) join service_provider using(spId) join service using(serviceId) where transactionId = ?  and timestamp < CURRENT_DATE");
    $query->bind_param('i', $id);
    $query->execute();
    $result = $query->get_result();
    
    $detail = mysqli_prepare($conn, "select * from paymentdetails join transaction using(transactionId) where transactionId = ? and (spStatus = 'approved' and custStatus = 'approved')");
    $detail->bind_param('i', $id);
    $detail->execute();
    $detailResult = $detail->get_result();
    
    $amt = mysqli_prepare($conn, "select sum(amount) as total from paymentdetails join transaction using(transactionId) where transactionId = ? and (spStatus = 'approved' and custStatus = 'approved')");
    $amt->bind_param('i', $id);
    $amt->execute();
    $total = $amt->get_result()->fetch_assoc();
    
    while ($rows = $result->fetch_assoc()){
        $mD = new DateTime($rows['timestamp']);
        if ($mD->format('m') == $month){
            if($mD->format('d') == $day){
                $dateOfTrans = $mD->format('h:i a');
                echo <<<frag
                    <div id="bookingDetails" style="float: right; margin-right: 5%;">
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

                while ($rows = $detailResult->fetch_assoc()){
                    echo "<tr>";
                    echo "<td>{$rows['serviceMade']}</td>";
                    echo "<td>{$rows['amount']}</td>";
                    echo "</tr>";
                }
                echo <<<frag
                                <tr>
                                    <th>Total:</th>
                                    <td>{$total['total']}</td>
                            </table>
                        </p>
frag;
            }
        }
            
    }
    
    $result->free_result();
}