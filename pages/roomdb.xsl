<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="4.01" indent="yes"/>
    <xsl:output doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
    <xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="room">
        <xsl:variable name="count" select="count(/hostelrooms/room)"/>
        <xsl:variable name="index" select="count(preceding-sibling::*[name() = name(current())])+1"/>
        <xsl:variable name="column" select="(count(preceding-sibling::*[name() = name(current())])+1) mod 5"/>
        <xsl:choose>
            <xsl:when test="$column = 0">
                <div class="lastitem roomitem">
                    <xsl:call-template name="rooms"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="item roomitem">
                    <xsl:call-template name="rooms"/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="rooms">
        <table>
            <tr>
                <td colspan="2"><center><b><xsl:value-of select="./@name"/></b></center></td>
            </tr>
            <tr>
                <td colspan="2"><center><img src="{image}" width="300" height="180"/></center></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <xsl:apply-templates select="price"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anz. Betten</b></td><td><xsl:apply-templates select="beds"/></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><xsl:apply-templates select="description"/></td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>