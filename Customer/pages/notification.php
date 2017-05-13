<?php
    require '../includes/blockedPages.php';


$query = mysqli_prepare($conn, "SELECT * from booking join service_provider using(spId) where (bookingStatus = 'accepted' or bookingStatus = 'rejected') and custId = ? order by notifTimestamp desc limit 5");

$query->bind_param('s', $userID);
$query->execute();

$result = $query->get_result();

$date = new DateTime("now");
if($result){
    while ($rows = mysqli_fetch_assoc($result)){
    $fName = $rows['firstName'];
    $lName = $rows['lastName'];
    $status = $rows['bookingStatus'];
    $timestamp = date_create($rows['notifTimestamp']);
    $ago = date_diff($timestamp, $date);

    echo <<<frag
        <li class="notification">
            <div class="media-body">
                <strong class="notification-title">$fName $lName</strong>
                <span class="notification-desc">has $status your service request</span>

                <div class="notification-meta">
                    <small class="timestamp">
frag;
                if($ago->d > 0 and $ago->d == 1){
                    echo "$ago->d day ago";
                } elseif ($ago->d > 1){
                    echo "$ago->d days ago";
                } elseif ($ago->h > 0 and $ago->h == 1){
                    echo "$ago->h hour ago";
                } elseif ($ago->h > 1){
                    echo "$ago->h hours ago";
                } elseif ($ago->i > 0 and $ago->i == 1){
                    echo "$ago->i minute ago";
                } elseif ($ago->i > 1){
                    echo "$ago->i minutes ago";
                }
    echo <<<frag
                    </small>
                </div>
            </div>   
        </li>
frag;
    }
}else {
    echo "<li class='notification'><div class='media-body'><strong class='notification-title'>You have no notifications</strong></div></li>";
}