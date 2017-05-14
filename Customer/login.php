<?php require 'includes/header.php'?>

    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
        <form role="form" method="post" action="" autocomplete="off">
            <h2>Please Enter Your Password</h2>
            <?php 
                include '/includes/login.php';
                $userName = filter_input(INPUT_GET, 'userName');
            ?>
            <input type="hidden" name="userName" value="<?php echo $userName ?>">
            <input class="form-control input-lg" type="password" name="pass" placeholder="Password" required="require"/>
            <input class="btn btn-primary btn-block btn-lg" type="submit" name="login" value="Login"/>
        </form>
    </div>

<?php require 'includes/footer.php';