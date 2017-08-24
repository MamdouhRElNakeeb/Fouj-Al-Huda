<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/21/17
 * Time: 1:25 PM
 */


$userID = htmlentities($_REQUEST["userID"]);
$msg = htmlentities($_REQUEST["msg"]);

if (empty($userID) || empty($msg)){

    $returnArray["status"] = "400";
    $returnArray["msg"] = "fail";
    echo json_encode($returnArray);
    return;
}

require ("secure/access.php");
require ("secure/qassemconn.php");

$access = new access(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$access->connect();

$result = $access->sendMsg($userID, $msg);

if ($result){
    $returnArray["error"] = FALSE;
    $returnArray["msg"] = "success";
    echo json_encode($returnArray);
}
else{
    $returnArray["error"] = TRUE;
    $returnArray["msg"] = "fail";
    echo json_encode($returnArray);
}

$access->disconnect();


?>