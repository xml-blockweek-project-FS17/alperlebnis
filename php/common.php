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

function convertToXMLDate($europeanDate){
    return $new_date = date('Y-m-d', strtotime($europeanDate));
}

function convertToEuropeanDate($xmlDate){
    return $new_date = date('d.m.Y', strtotime($xmlDate));
}

?>