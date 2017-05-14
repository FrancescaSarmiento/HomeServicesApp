

<div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    <form action="" method="post" autocomplete="off">
        <h2>Change Password</h2>
        <?php include '../includes/changePassword.php'?>
        <input type="hidden" name="id" value="<?php echo $userID ?>">
        <input class="form-control input-lg" type="password" name="currentPass" placeholder="Current Password" required="require">
        <input class="form-control input-lg" type="password" name="newPass" placeholder="New Password" required="require">
        <input class="form-control input-lg" type="password" name="confirmPass" placeholder="Confirm Password" required="require">
        <input class="btn btn-primary btn-block btn-lg" type="submit" name="submit" value="Submit">
    </form>
</div>