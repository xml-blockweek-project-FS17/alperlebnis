<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:import href="navigation.xsl"/>
    <!--Param should only be set over XSLTProcess->setParameter() but needs a placeholder to work properly-->
    <xsl:param name="message" select="''"/>
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>

    <xsl:template match="room">
        <div class="item roomitem">
            <xsl:call-template name="rooms"/>
        </div>
    </xsl:template>

    <xsl:template name="rooms">
        <div>
            <div class="roomImage" style="background-image:url({image})">
            </div>
        </div>

        <center><h2><xsl:value-of select="./@name"/></h2></center>

        <div class="message">
            <xsl:if test="string($message)">
                <xsl:value-of select="$message"/>
            </xsl:if>
        </div>
        <table id="{./@ID}" class="itemTable">
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <xsl:apply-templates select="price"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anz. Betten</b></td><td><xsl:apply-templates select="beds"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><xsl:apply-templates select="description"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><button type="button" class="bookroom" href="#">Buchen</button></td><td></td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>