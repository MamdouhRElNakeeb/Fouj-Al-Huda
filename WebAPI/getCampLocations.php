<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/6/17
 * Time: 3:53 PM
 */

require ("secure/access.php");
require("secure/qassemconn.php");

$access = new access(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$access->connect();
$services = $access->getTableContent("camp_locations");
$a = array();
$b = array();

if ($services != false) {
    while ($row = mysqli_fetch_array($services)) {
        $b["id"] = $row["id"];
        $b["name"] = $row["name"];
        $b["latitude"] = $row["latitude"];
        $b["longitude"] = $row["longitude"];
        $b["description"] = $row["description"];
        array_push($a, $b);
    }
    echo json_encode($a, JSON_UNESCAPED_UNICODE);
}

?>