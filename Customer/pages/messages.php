<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>
<h1>Messages</h1>
    <div id="left-side">
        <div class="btn-group-vertical">
            <?php checkCurrentMessages($conn, $userID);?>
        </div>
    </div>
<?php 
    if(!empty(filter_input(INPUT_POST, 'spId'))){ 
?>
        
    <div id="right-side">
        <div id="message">
            <?php 
                $spId = filter_input(INPUT_POST, 'spId');
                getMessages($conn, $spId, $userID)
            ?>
            
        </div>
            
            <div id="reply">
                <form class="form-inline send-message" method="post">
                    <div class="">
                        <textarea style="width: 300%; resize: none;" name="message" placeholder="Enter Your Message" required="require"></textarea>
                        <input class="btn btn-primary" type="submit" name="submit" value="Send" />
                    </div>
                        <?php 
                            $message = filter_input(INPUT_POST, 'message');
                            if(!empty($message)){   
                                reply($conn, $userID, $spId, $message);
                            }
                        ?>
                </form>
            </div>
    </div>
    <?php }