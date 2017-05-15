<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1><strong>Your Account Information:</strong></h1>

<?php $acctInfo = getAcctInfo($conn, $userID) ?>
<div class="information">
    <?php 
        $rows = mysqli_fetch_assoc($acctInfo);
    ?>
            
            <p>First Name: <?php echo $rows['firstName'] ?></p>
            <p>Last Name: <?php echo $rows['lastName'] ?></p>
            <p>Address: <?php echo $rows['address'] ?></p>
            <p>Email: <?php echo $rows['email'] ?></p>
            <p>Contact Number: <?php echo $rows['contactNumber'] ?></p>
            <p>Handy Zeb ID number and username: <?php echo $userID.' '.$rows['userName'] ?></p>
</div>
<div class="balance">
            <hr>
            <h3><strong>Your account balance: &#8369;<?php echo $rows['balance']?></strong></h3>
            <h6>Note: Your account will be deactivated once it reaches the balance limit of &#8369;5000.00</h6>
</div>