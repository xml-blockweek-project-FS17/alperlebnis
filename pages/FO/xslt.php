<?php

/**
 * perform XSLT transformation with PHP
 * @author Roland Christen <roland.christen@hslu.ch>
 * API: http://php.net/manual/en/class.xsltprocessor.php
 */

// load XML
$data = file_get_contents('../../data/activitydb.xml');
$xml = new DOMDocument();
$xml->loadXML($data);

// load XSL
$xsl = new DOMDocument();
$xsl->load('eventflyers.xsl');

// transform
$processor = new XSLTProcessor();
$processor->importStylesheet($xsl);
$dom = $processor->transformToDoc($xml);

// send result to client
$dom->save('eventflyers.fo');