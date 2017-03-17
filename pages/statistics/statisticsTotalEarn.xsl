<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg"
>
    <xsl:import href="./statisticsNav.xsl"/>
    <xsl:import href="../navigation.xsl"/>

    <xsl:param name="fromDate" select="''"/>
    <xsl:param name="toDate" select="''"/>

    <xsl:variable name="fromDateNum" select="number(translate($fromDate, '-', ''))"/>
    <xsl:variable name="toDateNum" select="number(translate($toDate, '-', ''))"/>

    <xsl:variable name="total" select="sum(//booking[number(translate(startdate, '-', '')) &gt;= $fromDateNum and number(translate(enddate, '-', '')) &lt;= $toDateNum]/paidprice)" />
    <xsl:variable name="curenccy" select="//room/price/@currency" />

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

    <xsl:template match="/">
        <xsl:call-template name="statNav" />
        <br />
        <br />
        <div>Totale Einnahmen:  <xsl:value-of select="$total"/> <xsl:value-of select="$curenccy"/></div>
        <xsl:call-template name="footer"/>
    </xsl:template>
</xsl:stylesheet>