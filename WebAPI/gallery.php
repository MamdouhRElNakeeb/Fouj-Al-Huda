<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/8/17
 * Time: 1:12 PM
 */


$a = array();

if ($handle = opendir('Gallery')) {

    while (false !== ($entry = readdir($handle))) {

        if ($entry != "." && $entry != "..") {

            array_push($a, $entry);
        }
    }
    echo json_encode($a, JSON_UNESCAPED_UNICODE);

    closedir($handle);
}

?>