<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="4.01" indent="yes"/>
    <xsl:output doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
    <xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN"/>

    

    <xsl:template match="activity">
        <xsl:variable name="column" select="(count(preceding-sibling::*[name() = name(current())])+1) mod 5"/>
        <xsl:choose>
            <xsl:when test="$column = 0">
                <div class="lastitem activityitem">
                    <xsl:call-template name="activities"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="item activityitem">
                    <xsl:call-template name="activities"/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="activities">
        <table>
            <tr>
                <td colspan="2"><center><b><xsl:value-of select="title"/></b></center></td>
            </tr>
            <tr>
                <td colspan="2"><center><img src="{image}" width="300" height="180"/></center></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anbieter</b></td><td><xsl:value-of select="provider"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <xsl:apply-templates select="price"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Durchführungsdatum</b></td><td><xsl:apply-templates select="activitydate"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anmeldestart</b></td><td><xsl:apply-templates select="signupstart"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anmedeschluss</b></td><td><xsl:apply-templates select="signupend"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Telefon</b></td><td><xsl:apply-templates select="contact/phone"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Email</b></td><td><a href="mailto:{contact/email}?Subject={title}" target="_top"><xsl:apply-templates select="contact/email"/></a></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><xsl:apply-templates select="description"/></td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>