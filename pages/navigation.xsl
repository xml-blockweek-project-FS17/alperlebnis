<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>

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
                <title><xsl:value-of select="$pageName"/></title>

                <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
                <meta name="description" content="XML Blockwoche Hostel Alperlebnis"/>
                <meta author="Philipp Disler, Marc Nussbaumer, Fabrizio Rohrbach, Jonas Studer"/>
                <meta name="keywords" lang="de" conent="Alpen, Berge,Bergbauern, HardcoreXML"/>
            </head>
    </xsl:template>

    <!-- Template HEADER-->
    <xsl:template name="header">
        <div id="header">
            <div id="wrap">
                <div style="width:100%"><img src="../data/pictures/header.png" width="970" height="150" alt="Alperlebnis+"/></div>
                <div id="navigation">
                    <button onclick="location.href='../pages/home.xml'" type="button">
                        Home
                    </button>
                    <button onclick="location.href='../pages/rooms.xml'" type="button">
                        Zimmerangebote
                    </button>
                    <button onclick="location.href='../pages/activitymanagement.xml'" type="button">
                        Angebotsverwaltung
                    </button>
                    <button onclick="checkLogin()" type="button">
                        Adminbereich
                    </button>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Template FOOTER-->
    <xsl:template name="footer">
        <div id="footer">
            <br/>

            2017 Alperlebnis+&#169; XML-Blockwoche
            <br/> Ersteller: Philipp Disler, Marc Nussbaumer, Fabrizio Rohrbach, Jonas Studer
            <br/>
        </div>
    </xsl:template>

</xsl:stylesheet>
