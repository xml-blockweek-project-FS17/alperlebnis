<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
<xsl:import href="navigation.xsl"/>
<!--Param should only be set over XSLTProcess->setParameter() but needs a placeholder to work properly-->
<xsl:param name="message" select="''"/>
<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>

<xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <xsl:call-template name="meta">
            <xsl:with-param name="pageName">Zimmerangebote</xsl:with-param>
        </xsl:call-template>
        <body>
            <xsl:call-template name="header" />

            <div class="message">
                <xsl:if test="string($message)">
                    <xsl:value-of select="$message"/>
                </xsl:if>
            </div>
            <div id="content">
            <!-- imports the elements from another xml to be searched-->
                <div>
                    <h1>Wilkommen bei Alperlebnis + </h1>
                    <h2>Hier werden Sie die Schweiz und das Napfgebiet in einem neuen und ebenso traditionellen Stil kennen lernen</h2>
                    <img src="../data/pictures/welcome.JPG" style="width:970px;height:680px;"></img>
                </div>
            </div>
            <div style="clear:both;"></div>
            <xsl:call-template name="footer"/>
        </body>
    </html>
</xsl:template>

</xsl:stylesheet>