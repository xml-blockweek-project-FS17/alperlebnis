<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                        xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:date="http://exslt.org/dates-and-times"
                >
    <xsl:import href="../navigation.xsl"/>
    <xsl:param name="form_action" select="'../php/selectStatistics.php'"/>
    <xsl:variable name="today" select="substring-before(date:date-time(), 'T')"/>

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" media-type="image/svg"/>

    <xsl:template name="statNav">
        <html lang="de">
            <xsl:call-template name="meta">
                <xsl:with-param name="pageName">Statistiken</xsl:with-param>
            </xsl:call-template>

            <body>
                <xsl:call-template name="header">
                    <xsl:with-param name="pageName">Statistiken</xsl:with-param>
                </xsl:call-template>
                <h1>Statistikübersicht</h1>

                <h3>Wählen Sie das gewünschte Zeitfenster für Ihre Statistik</h3>
                <form class="statisticsSelectionForm" action="{$form_action}" method="post">
                    <label for="startDate">Von: </label>
                    <input type="text" id="startDate" name="startDate" value="YYYY-MM-DD" maxlength="10"></input>
                    <br />
                    <label for="endDate">Bis: </label>
                    <input type="text" id="endDate" name="endDate" value="{$today}"></input>
                    <br />
                    <br />

                    <button name="actionId" type="submit" value="roomPrice">Zimmerpreise</button>
                    <button name="actionId" type="submit" value="roomOcc">Zimmerbelegung</button>
                    <button name="actionId" type="submit" value="totalEarn">Totale Einnahmen</button>
                </form>
                <!--
                <xsl:apply-templates select="document('../data/roomdb.xml')/hostelrooms"/>
                -->

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>