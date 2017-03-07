<?xml version="1.0" encoding="utf-8"?>

 
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
  
  <!-- Template META -->
  <xsl:template name="meta">
    <xsl:param name="pageName" />
    <head>
      <link rel="stylesheet" type="text/css" href="../css/style.css"/>
      <title>
        <xsl:value-of select="$pageName"/>
      </title>
 
      <meta name="description" content="XML Blockwoche Hostel Alperlebnis"/>
      <meta author="Philipp Disler, Marc Nussbaumer, Fabrizio Rohrbach, Jonas Studer"/>
      <meta name="keywords" lang="de" conent="Alpen, Berge,Bergbauern, HardcoreXML"/>
    </head>
  </xsl:template>
 
  <!-- Template HEADER-->
  <xsl:template name="header">
    <xsl:param name="pageName" />
    <div class="header">
        <div id="wrap">
      		<div style="width:100%"><img src="../data/pictures/header.png" width="970" height="150" alt="Alperlebnis+"/></div>
      		<div id="navigation">
      		  <button onclick="location.href='home.xml'" type="button">
              Home
            </button>
            <button onclick="location.href='rooms.xml'" type="button">
              Zimmerangebote
            </button>
            <button onclick="location.href='activitymanagement.xml'" type="button">
              Angebotsverwaltung
            </button>
             <button onclick="location.href='admin.xml'" type="button">
              Adminbereich
            </button>
      			
      		</div>
      		
      		<div id="content"></div>
      	</div>
    </div>
  </xsl:template>
 
  <!-- Template FOOTER-->
  <xsl:template name="footer">
    <div class="footer">
        <br/>
 
      2017 Alperlebnis+&#169; XML-Blockwoche
      <br/> Ersteller: Philipp Disler, Marc Nussbaumer, Fabrizio Rohrbach, Jonas Studer 
      <br/>
    </div>
  </xsl:template>
 
  
</xsl:stylesheet>
