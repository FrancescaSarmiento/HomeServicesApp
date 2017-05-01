<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header navbar-right">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#">Book</a></li>
                <li><a href="#">Messages<span class="badge">#</span></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $user; ?><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Transaction History</a></li>
                        <li><a href="#">Account Information</a></li>
                    </ul>
                <li><a href="../php/logout.php">Logout</a></li>
                </li>
            </ul>
        </div>
    </div>
</nav>

