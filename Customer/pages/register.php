<?php include '../includes/header.php'?>

    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
        <form role="form" method="post" action="" autocomplete="off">
            <h2>Please Sign Up</h2>
            <p>Already a member? <a href="login.php">Login</a></p>
            <?php include '../includes/register.php'?>
            <input class="form-control input-lg" type="text" name="fName" placeholder="First Name" required="required"/>
            <input class="form-control input-lg" type ="text" name="lName" placeholder="Last Name" required="required"/>
            <input class="form-control input-lg" type="text" name="address" placeholder="Address (Home #/Street/Barangay/City or Province" required="required"/>
            <input class="form-control input-lg" type="text" maxlength="11" name="cNumber" placeholder="Contact Number" required="required"/>
            <input class="form-control input-lg" type="email" name="email" placeholder="Email"/>
            <input class="form-control input-lg" type="text" name="username" placeholder="Username" required="required"/>
            <input class="form-control input-lg" type="password" name="pass" placeholder="Password" required="required"/>
            <input class="form-control input-lg" type="password" name="passConf" placeholder="Confirm password" required="required"/>
            <input class="btn btn-primary btn-block btn-lg" type="submit" name="register" value="Register"/>
        </form> 
    </div>

<?php include '../includes/footer.php';