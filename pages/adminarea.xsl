<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
>

    <xsl:import href="navigation.xsl"/>

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

    <xsl:template match="/">

        <html lang="de">
            <xsl:call-template name="meta">
                <xsl:with-param name="pageName">Admin area</xsl:with-param>
            </xsl:call-template>
            <body>
                <xsl:call-template name="header">
                    <xsl:with-param name="pageName">Admin area</xsl:with-param>
                </xsl:call-template>
                <div>
                    <h2> Willkommen im Adminbereich </h2>
                </div>
                <button type="button" id="navLink1" href="#" onclick="logout();">Log out</button>
                <xsl:call-template name="footer"/>
            </body>
        </html>


    </xsl:template>

</xsl:stylesheet>