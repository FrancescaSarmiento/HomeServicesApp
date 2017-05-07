<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>
<h1>Messages</h1>
    <div class="col-sm-2" id="left-side">
        <div class="">
            <?php checkCurrentMessages($conn, $userID);?>
        </div>
    </div>
<?php 
    if(!empty(filter_input(INPUT_GET, 'id'))){ 
?>
        
    <div class="col-md-9" id="right-side">
        <div >
            <?php 
                $spId= filter_input(INPUT_GET, 'id');
                getMessages($conn, $spId, $userID)
            ?>

            <form class="form-inline send-message" method="post">
                <div class="form-group"> 
                    <textarea class="form-control" name="message" placeholder="Enter Your Message" required="require"></textarea>
                <input  type="submit" name="submit" value="Send" />
                    <?php 
                        $message = filter_input(INPUT_POST, 'message');
                        if(!empty($message)){   
                            reply($conn, $userID, $spId, $message);
                            header('Location: main.php?page=messages&id='.$spId.'');
                        }
                    ?>
                </div>
            </form>
        </div>
    </div>
    <?php }