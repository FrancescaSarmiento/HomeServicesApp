<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>

<h1>Your Account Information:</h1>

<?php $acctInfo = getAcctInfo($conn, $userID) ?>
<div>
    <?php 
        $rows = mysqli_fetch_row($acctInfo);
    ?>
            
            <p>First Name: <input type="text" name="fname" disabled="disabled" value="<?php echo $rows[0] ?>"></p>
            <p>Last Name: <input type="text" name="lname" disabled="disabled" value="<?php echo $rows[1] ?>"></p>
            <p>Address: <input type="text" name="address" disabled="disabled" value="<?php echo $rows[2] ?>"></p>
            <p>Email: <input type="email" name="email" disabled="disabled" value="<?php echo $rows[3] ?>"></p>
            <p>Contact Number: <input type='text' name="cnumber" disabled="disabled" value="<?php echo $rows[4] ?>"></p>
            <p>Handy Zeb <?php echo $rows[5] ?> ID number and username: <?php echo $userID.' '.$rows[6] ?></p>
            
            <button name="toggle" value="toggle">Edit Account Information</button>
</div>