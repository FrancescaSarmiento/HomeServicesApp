<?php require '../includes/blockedPages.php' ?>

<nav class="navbar navbar-inverse navbar-fixed-top font">
    <div class="container-fluid">
        <div class="navbar-header navbar-right">
            <ul class="nav navbar-nav">
                 <li class="btn-group dropdown dropdown-notifications sw-open">
                  <button class="btn btn-link dropdown-toggle" data-toggle="dropdown" style="margin-top: 20%;">
                    <i class="glyphicon glyphicon-bell "></i>
                    <span class="caret"></span>
                  </button>

                  <div class="dropdown-container">
                   <div class="dropdown-toolbar">
                      <div class="dropdown-toolbar-actions">
                        <a href="?page=notifications"><i class="glyphicon glyphicon-search"></i> View All</a>
                      </div>
                      <h3 class="dropdown-toolbar-title">Recent Notifications</h3>
                    </div><!-- /dropdown-toolbar -->
                    <ul class="dropdown-menu notifications">
                        <?php include 'notification.php' ?>
                    </ul>
                  </div>
                </li>
                <li class="<?php if($page == 'home'){ echo 'active'; }?>"><a href="?page=home">Home</a></li>
                <li class="<?php if($page == 'about'){ echo 'active'; }?>"><a href="?page=about">About</a></li>
                <li class="<?php if($page == 'services'){ echo 'active'; }?>"><a href="?page=services">Services</a></li>
                <li class="<?php if($page == 'messages'){ echo 'active'; }?>"><a href="?page=messages">Messages<span class="badge"><!--?php getUnreadMessages(); ?>--></span></a></li>
                <li class="dropdown <?php if($page == 'transHist' || $page == 'acctInfo'){ echo 'active'; }?>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $_SESSION['firstName'] ?><span class="caret"></span></a>
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

