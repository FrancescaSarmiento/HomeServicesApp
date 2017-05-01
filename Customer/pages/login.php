<?php include 'header.php'?> 

<div id="login" class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    <form role="form" method="post" action="../php/login.php" autocomplete="off">
        <h2>Please Login</h2>
        <p>Back to <a href="../index.php">Register</a></p>
        <input class="form-control input-lg" type="text" name="username" placeholder="Username" required="require"/>
        <input class="form-control input-lg" type="password" name="password" placeholder="Password" required="require"/>
        <input class="btn btn-primary btn-block btn-lg" type="submit" name="login" value="Login"/>
    </form>
</div>

<?php include 'footer.php'?>