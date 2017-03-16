<?php

// load the FOP client.
require_once 'fop_service_client.php';

// locate the source FO file.
$foFile = 'bookingconfirmation.fo';

// create an instance of the FOP client and perform service request.
$serviceClient = new FOPServiceClient();
$pdfFile = $serviceClient->processFile($foFile);

// generate HTML output and show results of service request
echo '<h1>Buchungsbest&auml;tigung</h1>';
echo sprintf('<p>Ihre Buchung als PDF Download:<br><strong><a href="%s">%s</a></strong></p>', $pdfFile, $pdfFile);