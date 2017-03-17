<?php
require 'common.php';
//read form entries and invoke method from common.php to create new event

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if(isset($_POST["sourcexmlfile"])) { $GLOBALS['sourcexmlfile'] = $_POST['sourcexmlfile']; } else { exit(1); }
    if(isset($_POST["targetxmlfile"])) { $GLOBALS['targetxmlfile'] = $_POST['targetxmlfile']; } else { exit(1); }
    if(isset($_POST["xsdfile"])) { $GLOBALS['xsdfile'] = $_POST['xsdfile']; } else { exit(1); }
    if(isset($_POST["xslfile"])) { $GLOBALS['xslfile'] = $_POST['xslfile']; } else { exit(1); }
    if(isset($_POST["action"])) { $GLOBALS['action'] = $_POST['action']; } else { exit(1); }
    if(isset($_POST["params"])) { $GLOBALS['params'] = json_decode($_POST["params"]); } else { exit(1); }

    //dateisystem rechte überprüfen
    if(!file_exists($GLOBALS['sourcexmlfile'])) {
        echo "Kann die Datei (".$GLOBALS['sourcexmlfile'].") nicht finden!\n";
        exit(1);
    }
    if(!is_readable($GLOBALS['sourcexmlfile'])) {
        echo "Kann die Datei (".$GLOBALS['sourcexmlfile'].") nicht lesen!\n";
        exit(2);
    }
    if(file_exists($GLOBALS['targetxmlfile']) && !is_writable($GLOBALS['targetxmlfile'])) {
        echo "Kann die Datei (".$GLOBALS['targetxmlfile'].") nicht schreiben!\n";
        exit(3);
    }
    if(!file_exists($GLOBALS['xsdfile'])) {
        echo "Kann die Datei (".$GLOBALS['xsdfile'].") nicht finden!\n";
        exit(1);
    }
    if(!is_readable($GLOBALS['xsdfile'])) {
        echo "Kann die Datei (".$GLOBALS['xsdfile'].") nicht lesen!\n";
        exit(2);
    }
    if(!file_exists($GLOBALS['xslfile'])) {
        echo "Kann die Datei (".$GLOBALS['xslfile'].") nicht finden!\n";
        exit(1);
    }
    if(!is_readable($GLOBALS['xslfile'])) {
        echo "Kann die Datei (".$GLOBALS['xslfile'].") nicht lesen!\n";
        exit(2);
    }

    switch ($GLOBALS['action']) {
        case 'loadContent':
            loadContent();
            break;
        case 'loadFreeRooms':
            loadFreeRooms();
            break;
        case 'writeNewEvent':
            writeNewEvent();
            break;
        case 'addBooking':
            addBooking();
            break;
        case 'writeNewRoom':
            writeNewRoom();
            break;
        case 'deleteEvent':
            deleteEvent();
            break;
        case 'deleteRoom':
            deleteRoom();
            break;
        case 'editEvent':
            editEvent();
            break;
        case 'editRoom':
            editRoom();
            break;
        case 'writeNewBooking':
            writeNewBooking();
            break;
    }
}
function loadContent(){
    transformXml($GLOBALS['sourcexmlfile'], $GLOBALS['xsdfile'], $GLOBALS['xslfile'], $GLOBALS['params']);
}

function loadFreeRooms(){
    $bookstartdate = $GLOBALS["params"]->startdate;
    $bookenddate = $GLOBALS["params"]->enddate;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);

    // Load xml
    $xml = new DOMDocument;
    // $xml->validateOnParse = true;
    $xml->load($sourceFile);

    // Load XSL file
    $xsl = new DOMDocument;
    $xsl->validateOnParse = true;
    $xsl->load($GLOBALS['xslfile']);

    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    $removerooms = array();

    // get rooms
    $rooms = $xml->getElementsByTagName("room");
    foreach ($rooms as $room) {
        foreach($room->childNodes as $roomattrib){ // All attributes
            if($roomattrib->nodeType == 1 && $roomattrib->nodeName == 'bookings') {
                foreach($roomattrib->childNodes as $bookings){ // All bookings
                    if($bookings->nodeType == 1) // Node is Element
                    {
                        $startdate = '';
                        $enddate = '';
                        foreach ($bookings->childNodes as $bookingattrib) { // All bookingattributes
                            if($bookings->nodeType == 1) // Node is Element
                            {
                                if ($bookingattrib->nodeName == 'startdate') {
                                    $startdate = $bookingattrib->nodeValue;
                                }
                                if ($bookingattrib->nodeName == 'enddate') {
                                    $enddate = $bookingattrib->nodeValue;
                                }
                            }
                        }
                        if (datesOverlap($bookstartdate, $bookenddate, $startdate, $enddate)) {
                            array_push($removerooms, $room);
                            break;
                        }
                    }
                }
            }
        }
    }
    foreach ($removerooms as $removeroom) {
        $root=$xml->documentElement;
        $root->removeChild($removeroom);
    }

    if ($xml->schemaValidate( $GLOBALS['xsdfile']))
    {
        echo $proc->transformToXML($xml);
    }
    else
    {
        echo "Fehlerhafte Daten!";
        die();
    }
}

function editEvent(){
    $eventid = $GLOBALS["params"]->id;
    $title = $GLOBALS["params"]->title;
    $provider = $GLOBALS["params"]->provider;
    $activitydate = $GLOBALS["params"]->activitydate;
    $description = $GLOBALS["params"]->description;
    $image = $GLOBALS["params"]->image;
    $contact_phone = $GLOBALS["params"]->contact_phone;
    $contact_email = $GLOBALS["params"]->contact_email;
    $price = $GLOBALS["params"]->price;
    $signupstart = $GLOBALS["params"]->signupstart;
    $signupend = $GLOBALS["params"]->signupend;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    validateDataXml($sourceFile, $GLOBALS['xsdfile']);
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    // get activities
    $events = $dom->getElementsByTagName("activity");
    foreach ($events as $event) {
        if ($event->getAttribute("ID") == $eventid)
        {
            $toEdit = $event;
            break;
        }
    }
    if (isset($toEdit))
    {
        // change values
        $toEdit->getElementsByTagName("title")->item(0)->nodeValue = $title;
        $toEdit->getElementsByTagName("provider")->item(0)->nodeValue = $provider;
        $toEdit->getElementsByTagName("activitydate")->item(0)->nodeValue = convertToXMLDate($activitydate);
        $toEdit->getElementsByTagName("description")->item(0)->nodeValue = $description;
        $toEdit->getElementsByTagName("image")->item(0)->nodeValue = $image;
        $toEdit->getElementsByTagName("phone")->item(0)->nodeValue = $contact_phone;
        $toEdit->getElementsByTagName("email")->item(0)->nodeValue = $contact_email;
        $toEdit->getElementsByTagName("price")->item(0)->nodeValue = $price;
        $toEdit->getElementsByTagName("signupstart")->item(0)->nodeValue = convertToXMLDate($signupstart);
        $toEdit->getElementsByTagName("signupend")->item(0)->nodeValue = convertToXMLDate($signupend);

        if ($dom->schemaValidate( $GLOBALS['xsdfile']))
        {
            $dom->save($targetFile);
            echo 'Ihr Angebot erfolgreich editiert!';
        }
        else
        {
            echo "Fehlerhafte Daten!";
            die();
        }
    }
}

function writeNewEvent(){
    $title = $GLOBALS["params"]->title;
    $provider = $GLOBALS["params"]->provider;
    $activitydate = $GLOBALS["params"]->activitydate;
    $description = $GLOBALS["params"]->description;
    $image = $GLOBALS["params"]->image;
    $contact_phone = $GLOBALS["params"]->contact_phone;
    $contact_email = $GLOBALS["params"]->contact_email;
    $price = $GLOBALS["params"]->price;
    $signupstart = $GLOBALS["params"]->signupstart;
    $signupend = $GLOBALS["params"]->signupend;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);

    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    // enable validaiton
    $root=$dom->documentElement;

    $id = $root->getAttribute('nextActivityId');
    $nextId = $id + 1;

    $root->setAttribute('nextActivityId', $nextId);

    // new element with id
    $newEvent = $dom->createElement('activity');
    $newEvent->setAttribute('ID', $id);

    //title
    $xml_title = $dom->createElement('title', $title);
    $newEvent->appendChild($xml_title);

    //provider
    $xml_provider = $dom->createElement('provider', $provider);
    $newEvent->appendChild($xml_provider);

    //activitydate
    $xml_date = $dom->createElement('activitydate',convertToXMLDate($activitydate));
    $newEvent->appendChild($xml_date);

    //description
    $xml_desc = $dom->createElement('description',$description);
    $newEvent->appendChild($xml_desc);

    //image
    $xml_img = $dom->createElement('image',$image);
    $newEvent->appendChild($xml_img);

    //contact
    $xml_contact = $dom->createElement('contact');
    //phone
    $xml_tel = $dom->createElement('phone',$contact_phone);
    $xml_contact->appendChild($xml_tel);
    //email
    $xml_email = $dom->createElement('email',$contact_email);
    $xml_contact->appendChild($xml_email);
    $newEvent->appendChild($xml_contact);

    //price
    $xml_price = $dom->createElement('price',$price);
    $xml_price->setAttribute('currency', 'CHF');
    $newEvent->appendChild($xml_price);

    //signupstart
    $xml_start = $dom->createElement('signupstart',convertToXMLDate($signupstart));
    $newEvent->appendChild($xml_start);

    //signupsend
    $xml_start = $dom->createElement('signupend',convertToXMLDate($signupend));
    $newEvent->appendChild($xml_start);

    //Only for demo otherwise here would be the filter for the user (according to session)
    $insertroot = $root->getElementsByTagName("user")->item(0);
    $insertroot->appendChild($newEvent);

    if ($dom->schemaValidate( $GLOBALS['xsdfile']))
    {
        $dom->save($targetFile);
        echo 'Ihr Angebot wurde erfolgreich erstellt!';
    }
    else
    {
        echo "Fehlerhafte Daten!";
        die();
    }
}

function deleteEvent(){
    $id = $GLOBALS["params"]->id;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    $root=$dom->documentElement;
    $deleteroot = $root->getElementsByTagName("user")->item(0);
    $events = $dom->getElementsByTagName("activity");
    foreach ($events as $event) {
        if ($event->getAttribute("ID") == $id)
            $toRemove = $event;
    }

    if (isset($toRemove))
    {
        $deleteroot->removeChild($toRemove);
        $dom->save($targetFile);
        echo 'Angebot wurde erfolgreich gelöscht!';
    }
}

function editRoom(){
    $roomid = $GLOBALS["params"]->id;
    $roomname = $GLOBALS["params"]->name;
    $roomprice = $GLOBALS["params"]->price;
    $roombeds = $GLOBALS["params"]->beds;
    $roomimage = $GLOBALS["params"]->image;
    $roomdescription = $GLOBALS["params"]->description;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    validateDataXml($sourceFile, $GLOBALS['xsdfile']);
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    // get rooms
    $rooms = $dom->getElementsByTagName("room");
    foreach ($rooms as $room) {
        if ($room->getAttribute("ID") == $roomid)
        {
            $toEdit = $room;
            break;
        }
    }
    if (isset($toEdit))
    {
        // change values
        $toEdit->setAttribute('name', $roomname);
        $toEdit->getElementsByTagName("price")->item(0)->nodeValue = $roomprice;
        $toEdit->getElementsByTagName("beds")->item(0)->nodeValue = $roombeds;
        $toEdit->getElementsByTagName("image")->item(0)->nodeValue = $roomimage;
        $toEdit->getElementsByTagName("description")->item(0)->nodeValue = $roomdescription;

        if ($dom->schemaValidate( $GLOBALS['xsdfile']))
        {
            $dom->save($targetFile);
            echo 'Ihr Zimmer erfolgreich editiert!';
        }
        else
        {
            echo "Fehlerhafte Daten!";
            die();
        }
    }
}

function writeNewRoom(){
    $roomname = $GLOBALS["params"]->name;
    $roomprice = $GLOBALS["params"]->price;
    $roombeds = $GLOBALS["params"]->beds;
    $roomimage = $GLOBALS["params"]->image;
    $roomdescription = $GLOBALS["params"]->description;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);

    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    // enable validaiton
    $root=$dom->documentElement;

    $id = $root->getAttribute('nextRoomId');
    $nextId = $id + 1;

    $root->setAttribute('nextRoomId', $nextId);

    // new element with id
    $newRoom = $dom->createElement('room');
    $newRoom->setAttribute('name', $roomname);
    $newRoom->setAttribute('ID', $id);

    //price
    $xml_price = $dom->createElement('price', $roomprice);
    $xml_price->setAttribute('currency', 'CHF');
    $newRoom->appendChild($xml_price);

    //beds
    $xml_beds = $dom->createElement('beds', $roombeds);
    $newRoom->appendChild($xml_beds);

    //image
    $xml_image = $dom->createElement('image',$roomimage);
    $newRoom->appendChild($xml_image);

    //description
    $xml_description = $dom->createElement('description',$roomdescription);
    $newRoom->appendChild($xml_description);

    //bookings
    $xml_bookings = $dom->createElement('bookings','');
    $newRoom->appendChild($xml_bookings);

    //Only for demo otherwise here would be the filter for the user (according to session)
    $root->appendChild($newRoom);

    if ($dom->schemaValidate( $GLOBALS['xsdfile']))
    {
        $dom->save($targetFile);
        echo 'Ihr Zimmer wurde erfolgreich erstellt!';
    }
    else
    {
        echo "Fehlerhafte Daten!";
        die();
    }
}

function writeNewBooking(){
    $roomid = $GLOBALS["params"]->roomid;
    $bookstartdate = $GLOBALS["params"]->startdate;
    $bookenddate = $GLOBALS["params"]->enddate;
    $bookemail = $GLOBALS["params"]->email;
    $booksalutation = $GLOBALS["params"]->salutation;
    $bookfirstname = $GLOBALS["params"]->firstname;
    $booklastname = $GLOBALS["params"]->lastname;
    $bookaddress = $GLOBALS["params"]->address;
    $bookzipcode = $GLOBALS["params"]->zipcode;
    $bookstate = $GLOBALS["params"]->state;
    $bookcountry = $GLOBALS["params"]->country;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);

    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    // get rooms
    $rooms = $dom->getElementsByTagName("room");
    foreach ($rooms as $room) {
        if ($room->getAttribute("ID") == $roomid)
        {
            $toEdit = $room;
            break;
        }
    }

    if (isset($toEdit))
    {
        $roomname = $toEdit->getAttribute('name');
        $bookings = $toEdit->getElementsByTagName("bookings")->item(0);

        $id = $bookings->getAttribute('nextBookingId');
        $nextId = $id + 1;

        $bookings->setAttribute('nextBookingId', $nextId);

        // new element with id
        $booking = $dom->createElement('booking');
        $booking->setAttribute('ID', $id);

        //startdate
        $xml_startdate = $dom->createElement('startdate', $bookstartdate);
        $booking->appendChild($xml_startdate);

        //enddate
        $xml_enddate = $dom->createElement('enddate', $bookenddate);
        $booking->appendChild($xml_enddate);

        //email
        $xml_email = $dom->createElement('email', $bookemail);
        $booking->appendChild($xml_email);

        //paidprice
        $xml_paidprice = $dom->createElement('paidprice', '250.00');
        $booking->appendChild($xml_paidprice);

        //bookingaddress
        $xml_bookingaddress = $dom->createElement('bookingaddress', '');
        $bookingaddress = $booking->appendChild($xml_bookingaddress);

        //salutation
        $xml_salutation = $dom->createElement('salutation', $booksalutation);
        $bookingaddress->appendChild($xml_salutation);

        //firstname
        $xml_firstname = $dom->createElement('firstname', $bookfirstname);
        $bookingaddress->appendChild($xml_firstname);

        //lastname
        $xml_lastname = $dom->createElement('lastname', $booklastname);
        $bookingaddress->appendChild($xml_lastname);

        //address
        $xml_address = $dom->createElement('address', $bookaddress);
        $bookingaddress->appendChild($xml_address);

        //salutation
        $xml_zipcode = $dom->createElement('zipcode', $bookzipcode);
        $bookingaddress->appendChild($xml_zipcode);

        //state
        $xml_state = $dom->createElement('state', $bookstate);
        $bookingaddress->appendChild($xml_state);

        //country
        $xml_country = $dom->createElement('country', $bookcountry);
        $bookingaddress->appendChild($xml_country);

        //Only for demo otherwise here would be the filter for the user (according to session)
        $bookings->appendChild($booking);

        if ($dom->schemaValidate( $GLOBALS['xsdfile']))
        {
            $dom->save($targetFile);
            addLastBooking($roomname, $id);

            echo 'Ihr Buchung wurde erfolgreich erstellt!';
        }
        else
        {
            echo "Fehlerhafte Daten!";
            die();
        }
    }
}

function addLastBooking($roomname, $bookingid){
    $roomid = $GLOBALS["params"]->roomid;
    $bookstartdate = $GLOBALS["params"]->startdate;
    $bookenddate = $GLOBALS["params"]->enddate;
    $bookemail = $GLOBALS["params"]->email;
    $booksalutation = $GLOBALS["params"]->salutation;
    $bookfirstname = $GLOBALS["params"]->firstname;
    $booklastname = $GLOBALS["params"]->lastname;
    $bookaddress = $GLOBALS["params"]->address;
    $bookzipcode = $GLOBALS["params"]->zipcode;
    $bookstate = $GLOBALS["params"]->state;
    $bookcountry = $GLOBALS["params"]->country;

    $dom=new DOMDocument("1.0");
    $dom->validateOnParse = true;

    //to have indented output, not just a line
    $dom->preserveWhiteSpace = false;
    $dom->formatOutput = true;

    //creating an xslt adding processing line
    $xslt = $dom->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="../pages/bookingconfirmation.xsl"');

    //adding it to the xml
    $dom->appendChild($xslt);

    // new element with id
    $booking = $dom->createElement('booking');
    $booking->setAttribute('ID', $bookingid);

    //roomname
    $xml_roomname = $dom->createElement('roomname', $roomname);
    $booking->appendChild($xml_roomname);

    //startdate
    $xml_startdate = $dom->createElement('startdate', $bookstartdate);
    $booking->appendChild($xml_startdate);

    //enddate
    $xml_enddate = $dom->createElement('enddate', $bookenddate);
    $booking->appendChild($xml_enddate);

    //email
    $xml_email = $dom->createElement('email', $bookemail);
    $booking->appendChild($xml_email);

    //paidprice
    $xml_paidprice = $dom->createElement('paidprice', '250.00');
    $booking->appendChild($xml_paidprice);

    //bookingaddress
    $xml_bookingaddress = $dom->createElement('bookingaddress', '');
    $bookingaddress = $booking->appendChild($xml_bookingaddress);

    //salutation
    $xml_salutation = $dom->createElement('salutation', $booksalutation);
    $bookingaddress->appendChild($xml_salutation);

    //firstname
    $xml_firstname = $dom->createElement('firstname', $bookfirstname);
    $bookingaddress->appendChild($xml_firstname);

    //lastname
    $xml_lastname = $dom->createElement('lastname', $booklastname);
    $bookingaddress->appendChild($xml_lastname);

    //address
    $xml_address = $dom->createElement('address', $bookaddress);
    $bookingaddress->appendChild($xml_address);

    //salutation
    $xml_zipcode = $dom->createElement('zipcode', $bookzipcode);
    $bookingaddress->appendChild($xml_zipcode);

    //state
    $xml_state = $dom->createElement('state', $bookstate);
    $bookingaddress->appendChild($xml_state);

    //country
    $xml_country = $dom->createElement('country', $bookcountry);
    $bookingaddress->appendChild($xml_country);

    //Only for demo otherwise here would be the filter for the user (according to session)
    $dom->appendChild($booking);

    if ($dom->schemaValidate('../data/lastbooking.xsd'))
    {
        $dom->save('../data/lastbooking.xml');
    }
    else
    {
        echo "Fehlerhafte Daten!";
        die();
    }
}

function deleteRoom(){
    $id = $GLOBALS["params"]->id;

    $sourceFile = $GLOBALS['sourcexmlfile'];
    $targetFile = $GLOBALS['targetxmlfile'];

    // validate data.xml
    validateDataXml($sourceFile, $GLOBALS['xsdfile']);
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load($sourceFile);

    $root=$dom->documentElement;
    $rooms = $dom->getElementsByTagName("room");
    foreach ($rooms as $room) {
        if ($room->getAttribute("ID") == $id)
            $toRemove = $room;
    }

    if (isset($toRemove))
    {
        $root->removeChild($toRemove);
        $dom->save($targetFile);
        echo 'Zimmer wurde erfolgreich gelöscht!';
    }
}

function datesOverlap($start_one,$end_one,$start_two,$end_two) {

    if($start_one <= $end_two && $end_one >= $start_two) { //If the dates overlap
        return true;
    }

    return false; //Return 0 if there is no overlap
}
?>