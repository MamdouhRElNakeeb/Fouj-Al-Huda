<?php
/**
 * Created by PhpStorm.
 * User: mamdouhelnakeeb
 * Date: 8/6/17
 * Time: 3:49 PM
 */


class access{
    //connection global variables
    var $host = null;
    var $username = null;
    var $dpass = null;
    var $dname = null;
    var $conn = null;
    var $result = null;

    public function __construct($dbhost, $dbuser, $dbpass, $dbname){

        $this->host = $dbhost;
        $this->username = $dbuser;
        $this->dpass = $dbpass;
        $this->dname = $dbname;
    }

    public function connect(){
        $this->conn = new mysqli($this->host, $this->username, $this->dpass, $this->dname);
        if (mysqli_connect_errno()) {
            echo "Failed to connect to Database: " . mysqli_connect_error();
        }
        $this->conn->set_charset("utf8");
    }

    public function disconnect(){
        if($this->conn != null){
            $this->conn->close();
        }
    }

    public function getTableContent($tableName){

        $sql = "SELECT * FROM $tableName";
        $result = $this->conn->query($sql);
        return $result;

    }

    public function getChat($userID){

        $sql = "SELECT * FROM chat_msgs WHERE fromUserID=$userID OR toUserID=$userID";
        $result = $this->conn->query($sql);
        return $result;

    }

    // insert appointment into database
    public function sendMsg($id, $msg){

        $sql = "INSERT INTO chat_msgs SET fromUserID=?, msg=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 8 parameters of type string to be placed in $sql command
        $statement->bind_param("ss", $id, $msg);
        $returnValue = $statement->execute();
        return $returnValue;

    }

    // insert appointment into database
    public function contactMsg($id, $subject, $msg){

        $sql = "INSERT INTO contact_msgs SET userID=?, subject=?, msg=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 8 parameters of type string to be placed in $sql command
        $statement->bind_param("sss", $id, $subject, $msg);
        $returnValue = $statement->execute();
        return $returnValue;

    }

    // insert appointment into database
    public function chairOrder($id){

        $sql = "INSERT INTO chair_orders SET userID=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 8 parameters of type string to be placed in $sql command
        $statement->bind_param("s", $id);
        $returnValue = $statement->execute();
        return $returnValue;

    }

    // insert appointment into database
    public function fatwaRequest($question){

        $sql = "INSERT INTO fatawy SET question=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 8 parameters of type string to be placed in $sql command
        $statement->bind_param("s", $question);
        $returnValue = $statement->execute();
        return $returnValue;

    }

    // insert service into database
    public function insertCamp($name, $latitude, $longitude, $description){

        $sql = "INSERT INTO camp_locations SET name=?, latitude=?, longitude=?, description=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 4 parameters of type string to be placed in $sql command
        $statement->bind_param("ssss", $name, $latitude, $longitude, $description);
        $returnValue = $statement->execute();
        return $returnValue;

    }

    // insert photo into database
    public function insertPhoto($name, $description){

        $sql = "INSERT INTO Gallery SET name=?, description=?";
        $statement = $this->conn->prepare($sql);
        if(!$statement){
            throw new Exception($statement->error);
        }
        // bind 2 parameters of type string to be placed in $sql command
        $statement->bind_param("ss", $name, $description);
        $returnValue = $statement->execute();
        return $returnValue;

    }
}

?>