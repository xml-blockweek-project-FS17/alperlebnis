<?php

function validateDataXml($database, $schema) {
 
    // Load data xml
    $xml = new DOMDocument;
    $xml->validateOnParse = true;
    $xml->load($database);
    if (!$xml->schemaValidate($schema))
    {
        validationError();
        die();
    }
}
    
function deleteActivity($id){
 
    // validate data.xml
    validateDataXml();
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load("data.xml");
    $root=$dom->documentElement;
    $events = $dom->getElementsByTagName("activity");
    foreach ($events as $event) {
        if ($event->getAttribute("id") == $id)
            $toRemove = $event;
    }
 
    if (isset($toRemove))
    {
        $root->removeChild($toRemove);
        $dom->save('data.xml');
    }
}
    
function writeNewActivity($title, $creator, $contact, $price, $date, $start, $end, $tel, $email, $desc, $img ){
    // validate data.xml
    validateDataXml("../data/activitydb.xml","../data/activitydb_schema.xsd");
     
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load("../data/activitydb.xml");
     
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
    $xml_provider = $dom->createElement('provider', $creator);
    $newEvent->appendChild($xml_provider);
    
    //activitydate
    $xml_date = $dom->createElement('activitydate',convertToXMLDate($date));
    $newEvent->appendChild($xml_date);
    
    //description
    $xml_desc = $dom->createElement('description',$desc);
    $newEvent->appendChild($xml_desc);
    
     //image
    $xml_img = $dom->createElement('image',$img);
    $newEvent->appendChild($xml_img);
    
    //contact
    $xml_contact = $dom->createElement('contact');
        //phone
        $xml_tel = $dom->createElement('phone',$tel);
        $xml_contact->appendChild($xml_tel);
        //email
        $xml_email = $dom->createElement('email',$email);
        $xml_contact->appendChild($xml_email);
    $newEvent->appendChild($xml_contact);
    
     //price
    $xml_price = $dom->createElement('price',$price);
    $xml_price->setAttribute('currency', 'CHF');
    $newEvent->appendChild($xml_price);
    
    //signupstart
    $xml_start = $dom->createElement('signupstart',convertToXMLDate($start));
    $newEvent->appendChild($xml_start);
    
    //signupsend
    $xml_start = $dom->createElement('signupend',convertToXMLDate($end));
    $newEvent->appendChild($xml_start);
    
        
        
    
   


    
    $insertroot = $root->getElementsByTagName("user")->item(0);
    $insertroot->appendChild($newEvent); 

    if ($dom->schemaValidate('../data/activitydb_schema.xsd'))
    {
        $dom->save('../data/activitydb.xml');
        //success();
    }
    
    
}

function convertToXMLDate($europeanDate){
    return $new_date = date('Y-m-d', strtotime($europeanDate));
}

?>