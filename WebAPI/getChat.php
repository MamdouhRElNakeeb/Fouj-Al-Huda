<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/21/17
 * Time: 1:57 AM
 */

$userID = htmlentities($_REQUEST["userID"]);

if (empty($userID)){

    $returnArray["status"] = "400";
    $returnArray["msg"] = "userID is missing";
    echo json_encode($returnArray);
    return;
}

require ("secure/access.php");
require("secure/qassemconn.php");

$access = new access(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$access->connect();
$msgs = $access->getChat($userID);
$a = array();
$b = array();

if ($msgs != false) {
    while ($row = mysqli_fetch_array($msgs)) {
        $b["id"] = $row["id"];
        $b["fromUserID"] = $row["fromUserID"];
        $b["toUserID"] = $row["toUserID"];
        $b["msg"] = $row["msg"];
        array_push($a, $b);
    }
    echo json_encode($a, JSON_UNESCAPED_UNICODE);
}


?>