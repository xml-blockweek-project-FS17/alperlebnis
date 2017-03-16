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
            <div class="itemvaluename roomImage roomitemimage" style="background-image:url({image})">
                <button class="bookingButton bookroom" title="Buchungen"></button>
            </div>
        </div>

        <center><h2><div class="itemvaluename roomitemname"><xsl:value-of select="./@name"/></div></h2></center>

        <table id="{./@ID}" class="roomitemTable">
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <div class="roomitemprice"><xsl:apply-templates select="price"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anz. Betten</b></td><td><div class="roomitembeds"><xsl:apply-templates select="beds"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><div class="roomitemdescription"><xsl:apply-templates select="description"/></div></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="showbookingsdialog" title="Zimmerbuchungen Zimmer {./@name}" class="bookingsdialog" roomid="{./@ID}" style="display:none;">
                        <xsl:apply-templates select="bookings"/>
                    </div>
                </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>