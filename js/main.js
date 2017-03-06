function showWelcome()
{
	doXSLT('pages/home.xml','pages/home.xsl', 'content');
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
    var myNode = document.getElementById(elementname);
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

function loadXml(url) {
    var xhr;
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
        try { xhr.responseType = "msxml-document"; } catch (ex) {}
    } else {
        throw new Error("Failed to create XMLHTTP request object.");
    }
    xhr.open("GET", url, false);
    xhr.send();
    return xhr.responseXML;
}

function transformXml(xml, xsl) {
    var xsltProcessor;
    if (typeof xml === "string") xml = stringToXml(xml);
    if (typeof xsl === "string") xsl = stringToXml(xsl);
    if (window.XSLTProcessor) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        return xsltProcessor.transformToFragment(xml, document);
    } else if ("ActiveXObject" in window) {
        return xml.documentElement.transformNode(xsl);
    } else {
        throw new Error("Failed to transform XML.");
    }
}

function xmlToString(input) {
    var str;
    if (window.XMLSerializer) {
        return (new XMLSerializer()).serializeToString(input);
    } else if (input.xml) {
        return input.xml;
    } else {
        throw new Error("Failed to convert input to string.");
    }
    return str;
}

function stringToXml(input) {
    var xml;
    if ("ActiveXObject" in window) {
        xml = new ActiveXObject("Microsoft.XMLDOM");
        xml.async=false;
        xml.loadXML(input);
        return xml;
    } else if (window.DOMParser) {
        return (new DOMParser()).parseFromString(input, "text/xml");
    } else {
        throw new Error("Failed to convert input to XML document.");
    }
}

function setElementContent(element, content) {
    element.innerHTML = '';
    if (content.nodeType) {
        element.appendChild(content);
    } else {
        element.innerHTML = content;
    }
}

function loadXMLPage1(xmlpath, xslpath) {
    var xml = loadXml(xmlpath);
    var xsl = loadXml(xslpath);
    var element = document.getElementById('content');

    element.innerHTML = transformXml(xml,xsl);

}

function loadXMLPage2(xmlpath, xslpath) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        var content = document.getElementById('content');
        var xsl = loadXml(xslpath);
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