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

function transformXml($xml_file, $xsd_file, $xsl_file, $message) {
 
    // validate data.xml on each page request
    validateDataXml($xml_file, $xsd_file);
 
    // Load xml
    $xml = new DOMDocument;
   // $xml->validateOnParse = true;
    $xml->load($xml_file);
 
    // Load XSL file
    $xsl = new DOMDocument;
    $xsl->validateOnParse = true;
    $xsl->load($xsl_file);
 
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    
    /*The XSL needs a parameter with name message so this can work
    Easiest way to use is after the navigation import with the following line:
    define the param->  <xsl:param name="message" select="''"/>
    use the param-> <div class="message">
          <xsl:if test="string($message)">
            <xsl:value-of select="$message"/>
          </xsl:if>
        </div>
    */
    $proc->setParameter('', 'message', $message);  
    $proc->registerPHPFunctions();
 
    // Attach the xsl rules
    
    echo $proc->transformToXML($xml);
    
    
    
}

function loadActivityData($xml_file, $xsd_file, $xsl_file, $id, $message) {
 
    // validate data.xml on each page request
    validateDataXml($xml_file, $xsd_file);
 
    // Load xml
    $xml = new DOMDocument;
   // $xml->validateOnParse = true;
    $xml->load($xml_file);
 
    // Load XSL file
    $xsl = new DOMDocument;
    $xsl->validateOnParse = true;
    $xsl->load($xsl_file);
 
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    
     // get event
    $events = $xml->getElementsByTagName("activity");
    foreach ($events as $event) {
        if ($event->getAttribute("ID") == $id)
        {
            $toRead = $event;
            break;
        }
    }
    if (isset($toRead))
    {
    // change values
        $title = $toRead->getElementsByTagName("title")->item(0)->nodeValue;
        $provider = $toRead->getElementsByTagName("provider")->item(0)->nodeValue;
        $date = $toRead->getElementsByTagName("activitydate")->item(0)->nodeValue;
        $desc = $toRead->getElementsByTagName("description")->item(0)->nodeValue;
        $img = $toRead->getElementsByTagName("image")->item(0)->nodeValue;
        $phone = $toRead->getElementsByTagName("phone")->item(0)->nodeValue;
        $email = $toRead->getElementsByTagName("email")->item(0)->nodeValue;
        $price = $toRead->getElementsByTagName("price")->item(0)->nodeValue;
        $start = $toRead->getElementsByTagName("signupstart")->item(0)->nodeValue;
        $end = $toRead->getElementsByTagName("signupstart")->item(0)->nodeValue;
    }
    
    //Element that is currently in edit mode should not be shown anymore
    $deleteroot = $xml->getElementsByTagName("user")->item(0);
    $deleteroot->removeChild($toRead);
    
    $proc->setParameter('', 'message', $message);  
    $proc->setParameter('', 'param_id', $id); 
    $proc->setParameter('', 'submit_button', 'Änderungen speichern');
    $proc->setParameter('', 'param_title',$title); 
    $proc->setParameter('', 'param_provider',$provider); 
    $proc->setParameter('', 'param_activitydate',$date); 
    $proc->setParameter('', 'param_desc',$desc); 
    $proc->setParameter('', 'param_image',$img); 
    $proc->setParameter('', 'param_phone',$phone); 
    $proc->setParameter('', 'param_email',$email); 
    $proc->setParameter('', 'param_price',$price); 
    $proc->setParameter('', 'param_start',$start); 
    $proc->setParameter('', 'param_end',$end); 
    $proc->setParameter('', 'form_action','../php/editActivity.php'); 
    $proc->registerPHPFunctions();
 
    // Attach the xsl rules
    
    echo $proc->transformToXML($xml);
    
    
    
}
    
function deleteActivity($id){
 
    // validate data.xml
    validateDataXml("../data/activitydb.xml","../data/activitydb_schema.xsd");
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load("../data/activitydb.xml");
    
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
        $dom->save("../data/activitydb.xml");
        transformXml("../data/activitydb.xml", "../data/activitydb_schema.xsd", "../pages/activitymanagement.xsl","Angebot wurde erfolgreich gelöscht!" );
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
    
    //Only for demo otherwise here would be the filter for the user (according to session)
    $insertroot = $root->getElementsByTagName("user")->item(0);
    $insertroot->appendChild($newEvent); 

    if ($dom->schemaValidate('../data/activitydb_schema.xsd'))
    {
        $dom->save('../data/activitydb.xml');
        transformXml("../data/activitydb.xml", "../data/activitydb_schema.xsd", "../pages/activitymanagement.xsl","Ihr Angebot wurde erfolgreich erstellt!" );
    }
    
    
}


function editActivity($id, $title, $creator, $price, $date, $start, $end, $tel, $email, $desc, $img){
 
    validateDataXml("../data/activitydb.xml","../data/activitydb_schema.xsd");
    $dom=new DOMDocument();
    $dom->validateOnParse = true;
    $dom->load("../data/activitydb.xml");
 
    // get event
    $events = $dom->getElementsByTagName("activity");
    foreach ($events as $event) {
        if ($event->getAttribute("ID") == $id)
        {
            $toEdit = $event;
            break;
        }
    }
    if (isset($toEdit))
    {
    // change values
        $toEdit->getElementsByTagName("title")->item(0)->nodeValue = $title;
        $toEdit->getElementsByTagName("provider")->item(0)->nodeValue = $creator;
        $toEdit->getElementsByTagName("activitydate")->item(0)->nodeValue = $date;
        $toEdit->getElementsByTagName("description")->item(0)->nodeValue = $desc;
        $toEdit->getElementsByTagName("image")->item(0)->nodeValue = $img;
        $toEdit->getElementsByTagName("phone")->item(0)->nodeValue = $tel;
        $toEdit->getElementsByTagName("email")->item(0)->nodeValue = $email;
        $toEdit->getElementsByTagName("price")->item(0)->nodeValue = $price;
        $toEdit->getElementsByTagName("signupstart")->item(0)->nodeValue = $start;
        $toEdit->getElementsByTagName("signupend")->item(0)->nodeValue = $end;
         
        if (!$dom->schemaValidate("../data/activitydb_schema.xsd"))
        {
            echo "invalid data";
            die();
        }
 
        // save
        $dom->save("../data/activitydb.xml");
        transformXml("../data/activitydb.xml", "../data/activitydb_schema.xsd", "../pages/activitymanagement.xsl","Ihr Angebot erfolgreich editiert!" );  
    }
}

function convertToXMLDate($europeanDate){
    return $new_date = date('Y-m-d', strtotime($europeanDate));
}

function convertToEuropeanDate($xmlDate){
    return $new_date = date('d.m.Y', strtotime($europeanDate));
}

?>