<?xml version="1.0" encoding="utf-8"?>

 
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
  
  <!-- Template META -->
  <xsl:template name="meta">
    <xsl:param name="pageName" />
    <head>
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui.css"/>
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui.structure.css"/>
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui.theme.css"/>
        <link rel="stylesheet" type="text/css" href="../css/style.css"/>
        <script src="../js/jquery-3.1.1.js" type="text/javascript">&#160;</script>
        <script src="../js/jquery-ui.js" type="text/javascript">&#160;</script>
        <script src="../js/jquery.cookie.js" type="text/javascript">&#160;</script>
        <script src="../js/main.js" type="text/javascript">&#160;</script>
        <script src="../js/login.js" type="text/javascript">&#160;</script>
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
                <button onclick="location.href='../pages/home.xml'" type="button">Home</button>
                <button onclick="location.href='../pages/rooms.xml'" type="button">Zimmer</button>
                <button onclick="location.href='../pages/activity.xml'" type="button">Aktivitäten</button>
                <button onclick="location.href='../pages/statistics.xml'" type="button">Statistiken</button>
                <button onclick="checkLogin()" type="button">Verwaltung</button>
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
