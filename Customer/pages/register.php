<?php include 'pages/header.php'?>

<div class="register col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    <form role="form" action="php/register.php" method="POST" enctype="multipart/form-data" autocomplete="off">
            <h2>Please Sign Up</h2>
            <p>Already a member? <a href="pages/login.php">Login</a></p>
            <input class="form-control input-lg" type="text" name="firstname" placeholder="First Name" required="required"/>
            <input class="form-control input-lg" type ="text" name="lastname" placeholder="Last Name" required="required"/>
            <input class="form-control input-lg" type="text" name="address" placeholder="Address (Home #/Street/Barangay/City or Province" required="required"/>
            <input class="form-control input-lg" type="text" maxlength="11" name="cNumber" placeholder="Contact Number" required="required"/>
            <input class="form-control input-lg" type="email" name="email" placeholder="Email"/>
            <input class="form-control input-lg" type="text" name="username" placeholder="Username" required="required"/>
            <input class="form-control input-lg" type="password" name="password" placeholder="Password" required="required"/>
            <input class="form-control input-lg" type="password" name="passwordConfirmation" placeholder="Confirm password" required="required"/>
            <input class="btn btn-primary btn-block btn-lg" type="submit" name="register" value="Register"/>
        </form> 
</div>

<?php include 'pages/footer.php';