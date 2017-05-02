<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header navbar-right">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="?page=home">Home</a></li>
                <li><a href="?page=about">About</a></li>
                <li><a href="?page=services">Services</a></li>
                <li><a href="?page=messages">Messages<span class="badge">#</span></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $user ?><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="?page=transHist">Transaction History</a></li>
                        <li><a href="?page=acctInfo">Account Information</a></li>
                    </ul>
                <li><a href="../includes/logout.php">Logout</a></li>
                </li>
            </ul>
        </div>
    </div>
</nav>

