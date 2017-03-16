<?php

// load the FOP client.
require_once 'fop_service_client.php';

// locate the source FO file.
$foFile = 'eventflyers.fo';

// create an instance of the FOP client and perform service request.
$serviceClient = new FOPServiceClient();
$pdfFile = $serviceClient->processFile($foFile);

// generate HTML output and show results of service request
echo '<h1>&Uuml;bersicht der aktuellen Aktivit&auml;ten</h1>';
echo sprintf('<p>&Uuml;bersicht als PDF Download:<br><strong><a href="%s">%s</a></strong></p>', $pdfFile, $pdfFile);