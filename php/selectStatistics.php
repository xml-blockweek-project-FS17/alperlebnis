<?php
require 'common.php';
//read form entries and invoke method from common.php to create new event

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $startDate = $_POST['startDate'];
    $endDate = $_POST['endDate'];
    $actionId = $_POST['actionId'];

    if($actionId == "wins"){
        showStatistic("../data/roomdb.xml", "../data/roomdb_schema.xsd", "../pages/statistics/statisticsEarn.xsl", $startDate, $endDate);
    } elseif ($actionId == "activities"){

    }
}

function showStatistic($xml_file, $xsd_file, $xsl_file, $startDate, $endDate) {
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

    $proc->setParameter('', 'fromDate', $startDate);
    $proc->setParameter('', 'toDate', $endDate);
    $proc->registerPHPFunctions();

    // Attach the xsl rules
    echo $proc->transformToXML($xml);
}

function buildSVGXml(){
    $xml = new DOMDocument();
    $xml_album = $xml->createElement("Album");
    $xml_track = $xml->createElement("Track");
    $xml_album->appendChild( $xml_track );
    $xml->appendChild( $xml_album );
}
?>