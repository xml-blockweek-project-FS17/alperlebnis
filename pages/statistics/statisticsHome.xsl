<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                        xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
                >
    <xsl:import href="./statisticsNav.xsl"/>
    <xsl:import href="../navigation.xsl"/>

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" media-type="image/svg"/>
    <xsl:template match="/">
        <xsl:call-template name="statNav"/>
        <xsl:call-template name="footer"/>
    </xsl:template>
</xsl:stylesheet>