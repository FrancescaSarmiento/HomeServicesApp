<?php 
    require '../includes/blockedPages.php';
    require '../includes/functions.php';
?>
<h1 class="center"><strong>M E S S A G E S</strong></h1>
    <div id="left-side">
        <span class="center">INBOX</span><br><br>
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
                    <div class="inputMessage">
                        <textarea style="width: 300%; resize: none;" name="message" placeholder="Enter Your Message" required="require"></textarea>
                        <input class="btn btn-primary" type="submit" name="submit" value="Send" />
                    </div>
                    </div>
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