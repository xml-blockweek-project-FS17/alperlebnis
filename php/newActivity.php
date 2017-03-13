<?php
require 'common.php';
//read form entries and invoke method from common.php to create new event
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = $_POST['title'];
    $creator = $_POST['creator'];
    $price = $_POST['price'];
    $date = $_POST['date'];
    $start = $_POST['startregister'];
    $end = $_POST['endregister'];
    $tel = $_POST['telephone'];
    $email = $_POST['email'];
    $desc = $_POST['description'];
    $img = $_POST['image'];
     
    writeNewActivity($title, $creator, $contact, $price, $date, $start, $end, $tel, $email, $desc, $img );
}
else {
    transformXml('newEvent');
}
?>