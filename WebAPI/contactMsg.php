<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/9/17
 * Time: 3:56 AM
 */



$userID = htmlentities($_REQUEST["userID"]);
$subject = htmlentities($_REQUEST["subject"]);
$msg = htmlentities($_REQUEST["msg"]);

if (empty($userID) || empty($subject) || empty($msg)){

    $returnArray["status"] = "400";
    $returnArray["msg"] = "fail";
    echo json_encode($returnArray);
    return;
}

require ("secure/access.php");
require ("secure/qassemconn.php");

$access = new access(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$access->connect();

$result = $access->contactMsg($userID, $subject, $msg);

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