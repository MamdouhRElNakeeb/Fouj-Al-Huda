<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/11/17
 * Time: 1:57 PM
 */


require ("secure/access.php");
require("secure/qassemconn.php");

$access = new access(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$access->connect();
$services = $access->getTableContent("fatawy");
$a = array();
$b = array();

if ($services != false) {
    while ($row = mysqli_fetch_array($services)) {
        if ($row["answer"] != null){

            $b["id"] = $row["id"];
            $b["question"] = $row["question"];
            $b["answer"] = $row["answer"];
            array_push($a, $b);

        }
    }
    echo json_encode($a, JSON_UNESCAPED_UNICODE);
}

?>