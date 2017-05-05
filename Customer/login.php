<?php require 'includes/header.php'?>

    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
        <form role="form" method="post" action="" autocomplete="off">
            <h2>Please Login</h2>
            <p>Back to <a href="register.php">Register</a></p>
            <?php include '/includes/login.php'?>
            <input class="form-control input-lg" type="text" name="username" placeholder="Username" required="require"/>
            <input class="form-control input-lg" type="password" name="pass" placeholder="Password" required="require"/>
            <input class="btn btn-primary btn-block btn-lg" type="submit" name="login" value="Login"/>
        </form>
    </div>

<?php require 'includes/footer.php';