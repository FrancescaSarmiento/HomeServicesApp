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
                <form class="form-inline send-message" method="post" action="main.php?page=messages">
                    <div class="inputMessage">
                        <input type="hidden" name="spId" value="<?php echo $spId ?>">
                        <input type="hidden" name="spid" value="<?php echo $spId ?>">
                        <input type="hidden" name="user" value="<?php echo $userID ?>">
                        <textarea style="width: 300%; resize: none;" name="message" placeholder="Enter Your Message" required></textarea>
                        <input class="btn btn-primary" type="submit" name="submit" value="Send" onclick="window.location.reload()"/>
                    </div>
                </form>
            </div>
            <?php 
                if(!empty(filter_input(INPUT_POST, 'message'))){   
                    $ct = date('Y-m-d H:i:s');
                    $messageBody = filter_input(INPUT_POST, 'message');
                    $spID = filter_input(INPUT_POST, 'spid');
                    $userID = filter_input(INPUT_POST, 'user');
                    $message = htmlspecialchars($messageBody);
                    $result = mysqli_query($conn, "INSERT INTO message (senderId, receiverId, messageBody, timeSent) VALUES ('$userID','$spID','$message','$ct')") or die(mysqli_error($conn));
                
                    unset($ct);
                    unset($messageBody);
                    unset($spID);
                    unset($message);
                }
            ?>
    </div>
<?php 
    }