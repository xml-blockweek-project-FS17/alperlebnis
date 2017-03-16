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
                        <td class="eventLeftColumn">Von</td>
                        <td>
                            <input type="text" name="book_startdate" id="book_startdate" placeholder="yyyy-MM-dd" size="9" class="datepicker"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="eventLeftColumn">Bis</td>
                        <td>
                            <input type="text" name="book_enddate" id="book_enddate" placeholder="yyyy-MM-dd" size="9" class="datepicker"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan = "2"><button type="button" id="showroom" href="#">Anzeigen</button></td>
                    </tr>
                </table>
                <div style="clear:both;"></div>
                <div id="bookroomdialog" class="dialog" title="Zimmer buchen" style="display:none;">
                    <form method="post">
                        <table>
                            <tr>
                                <td class="eventLeftColumn">E-Mail</td>
                                <td>
                                    <input type="email" name="book_email" placeholder="E-Mail" id="book_email" size="30" required="required" autofocus="autofocus"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Anrede</td>
                                <td style="text-align: left;">
                                    <select name="book_salutation" id="book_salutation" required="required">
                                        <option value="herr">Herr</option>
                                        <option value="frau">Frau</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Vorname</td>
                                <td>
                                    <input type="text" name="book_firstname" placeholder="Vorname" id="book_firstname" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Nachname</td>
                                <td>
                                    <input type="text" name="book_lastname" placeholder="Nachname" id="book_lastname" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Addresse</td>
                                <td>
                                    <input type="text" name="book_address" placeholder="Addresse" id="book_address" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">PLZ</td>
                                <td>
                                    <input type="text" name="book_zipcode" placeholder="ZIP Code" id="book_zipcode" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Ort</td>
                                <td>
                                    <input type="text" name="book_state" placeholder="Ort" id="book_state" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="eventLeftColumn">Land</td>
                                <td>
                                    <input type="text" name="book_country" placeholder="Land" id="book_country" size="30" required="required"/>
                                </td>
                            </tr>
                            <tr>
                                <br/>
                            </tr>
                        </table>
                    </form>
                </div>
                <div style="clear:both;"></div>
                <div id="content"></div>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>