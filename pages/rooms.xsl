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
                <table class="newBookingTable">
                    <tr>
                        <td class="eventLeftColumn">Anmeldedatum Start</td>
                        <td>
                            <input type="date" name="book_startdate" id="book_startdate" placeholder="yyyy-MM-dd" size="9" class="datepicker"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="eventLeftColumn">Anmeldedatum Ende</td>
                        <td>
                            <input type="date" name="book_enddate" id="book_enddate" placeholder="yyyy-MM-dd" size="9" class="datepicker"/>
                        </td>
                    </tr>
                </table>
                <div style="clear:both;"></div>
                <div id="content"></div>
                <div style="clear:both;"></div>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>