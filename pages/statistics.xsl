<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                        xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
                >
 
  <xsl:import href="navigation.xsl"/>
 
  <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" media-type="image/svg"/>

    <xsl:template match="/">
        <html lang="de">
            <xsl:call-template name="meta">
                <xsl:with-param name="pageName">Statistiken</xsl:with-param>
            </xsl:call-template>

            <body>
                <xsl:call-template name="header">
                    <xsl:with-param name="pageName">Statistiken</xsl:with-param>
                </xsl:call-template>
                <!--
                <xsl:apply-templates select="document('../data/roomdb.xml')/hostelrooms"/>
                -->
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>