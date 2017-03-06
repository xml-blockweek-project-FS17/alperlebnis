function init() {
    doXSLT('data/roomdb.xml', 'pages/roomdb.xsl', 'content-tabs-1');
    doXSLT('data/activitydb.xml', 'pages/activitydb.xsl', 'content-tabs-2');
}

function loadXMLDoc(filename)
{
    if (window.ActiveXObject)
    {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    else
    {
        xhttp = new XMLHttpRequest();
    }
    xhttp.open("GET", filename, false);
    try {xhttp.responseType = "msxml-document"} catch(err) {} // Helping IE11
    xhttp.send("");
    return xhttp.responseXML;
}

function doXSLT(xmlfilename, xslfilename, elementname)
{
    xml = loadXMLDoc(xmlfilename);
    xsl = loadXMLDoc(xslfilename);
    var myNode = document.getElementById("content");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
    {
        ex = xml.transformNode(xsl);
        while (myNode.firstChild) {
            myNode.removeChild(myNode.firstChild);
        }
        myNode.innerHTML = ex;
    }
    // code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
    {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml, document);
        while (myNode.firstChild) {
            myNode.removeChild(myNode.firstChild);
        }
        myNode.appendChild(resultDocument);
    }
}

function loadXMLPage(url) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        var content = document.getElementById('content');
        content.innerHTML = "";
        if (this.readyState == 4 && this.status == 200) {
            content.innerHTML = this.responseText;
            content.innerHTML = '<br>Some new content!';
            content.innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", url, true);
    xhttp.send();
}