<?php
require 'common.php';
//read form entries and invoke method from common.php to create new event
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    echo $id;
    //deleteActivity($id);
}
else {
    //Display page if no post-data is available
    transformXml("../data/activitydb.xml", "../data/activitydb_schema.xsd", "../pages/activitymanagement.xsl","" );
}
?>