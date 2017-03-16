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
                <xsl:apply-templates select="document('../data/activitydb.xml')/activities"/>
                <div style="clear: both;"></div>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="activity">
        <div class="item activityitem">
            <xsl:call-template name="activities"/>
        </div>
    </xsl:template>

    <xsl:template name="activities">
        <div>
            <div class="itemvaluename activityImage eventitemimage" style="background-image:url({image})">
            </div>
        </div>

        <center><h2><div class="itemvaluename eventitemtitle"><xsl:value-of select="title"/></div></h2></center>

        <table id="{./@ID}" class="activityitemTable">
            <tr>
                <td class="itemvaluename"><b>Anbieter</b></td><td><div class="eventitemprovider"><xsl:value-of select="provider"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <div class="eventitemprice"><xsl:apply-templates select="price"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Durchführungsdatum</b></td><td><div class="eventitemactivitydate"><xsl:apply-templates select="activitydate"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anmeldestart</b></td><td><div class="eventitemsignupstart"><xsl:apply-templates select="signupstart"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anmedeschluss</b></td><td><div class="eventitemsignupend"><xsl:apply-templates select="signupend"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Telefon</b></td><td><div class="eventitemphone"><xsl:apply-templates select="contact/phone"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Email</b></td><td><a href="mailto:{contact/email}?Subject={title}" target="_top"><div class="eventitememail"><xsl:apply-templates select="contact/email"/></div></a></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><div class="eventitemdescription"><xsl:apply-templates select="description"/></div></td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>