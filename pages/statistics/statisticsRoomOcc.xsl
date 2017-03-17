<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns="http://www.w3.org/2000/svg"
>
    <xsl:import href="./statisticsNav.xsl"/>
    <xsl:import href="../navigation.xsl"/>

    <xsl:param name="fromDate" select="''"/>
    <xsl:param name="toDate" select="''"/>

    <xsl:variable name="fromDateNum" select="number(translate($fromDate, '-', ''))"/>
    <xsl:variable name="toDateNum" select="number(translate($toDate, '-', ''))"/>

    <xsl:variable name="occupiedRooms" select="count(//room/bookings/booking[number(translate(startdate, '-', '')) &gt;= $fromDateNum and number(translate(enddate, '-', '')) &lt;= $toDateNum])" />
    <xsl:variable name="totalRooms" select="count(//room)" />
    <xsl:variable name="freeRooms" select="$totalRooms - $occupiedRooms" />


    <xsl:variable name="chartWidth" select="600" />
    <xsl:variable name="chartHeight" select="400" />
    <xsl:variable name="viewHeight" select="$chartHeight - 50" />
    <xsl:variable name="lineWidth" select="$chartWidth - 100" />

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

    <xsl:template match="/">
        <xsl:call-template name="statNav" />

        <br />
        <br />

        <div class="chartHeader" style="width:{$chartWidth}px;">Zimmerbelegung</div>
        <div class="barchart" style="width: {$chartWidth}px; height: {$chartHeight}px;">
            <div class="blockWrapper">
                <div class="blockItem" style="margin-left: 0px">
                    <xsl:value-of select="$totalRooms"/>
                    <div class="block" style="height: {(number($totalRooms) div $totalRooms)*($viewHeight)}px;"></div>
                    <div class="label">
                        Total Räume
                    </div>
                </div>
                <div class="blockItem" style="margin-left: 80px">
                    <xsl:value-of select="$freeRooms"/>
                    <div class="block" style="height: {(number($freeRooms) div $totalRooms)*($viewHeight)}px;"></div>
                    <div class="label">
                        Freie Räume
                    </div>
                </div>
                <div class="blockItem" style="margin-left: 160px">
                    <xsl:value-of select="$occupiedRooms"/>
                    <div class="block" style="height: {(number($occupiedRooms) div $totalRooms)*($viewHeight)}px;"></div>
                    <div class="label">
                        Besetzte Räume
                    </div>
                </div>
            </div>
        </div>



    <!--
        <div class="barchart">
            <div class="blockWrapper">
                <div class="blockItem">
                    <div class="block" style="height:74px;"></div>
                    <div class="label">2007</div>
                </div>
                <div class="blockItem">
                    <div class="block" style="height:159px;"></div>
                    <div class="label">2008</div>
                </div>
                <div class="blockItem">
                    <div class="block" style="height:221px;"></div>
                    <div class="label">2009</div>
                </div>
            </div>
        </div>
        -->



        <!--
        <xsl:for-each select="//booking[number(translate(startdate, '-', '')) &gt;= $fromDateNum and number(translate(enddate, '-', '')) &lt;= $toDateNum]">
            <div><xsl:value-of select="paidprice"/></div>
        </xsl:for-each>

        <xsl:for-each select="//room[number(translate(startdate, '-', '')) &gt;= $fromDateNum and number(translate(enddate, '-', '')) &lt;= $toDateNum]">
            <div><xsl:value-of select="paidprice"/></div>
        </xsl:for-each>
        -->

        <!--
        <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" >
            <xsl:apply-templates select="hostelrooms"/>
        </svg>
        -->

        <xsl:call-template name="footer"/>
    </xsl:template>

<!--
    <xsl:template match="hostelrooms">
        <rect x="10" y="105" width="{10 * count(room)}"
              height="5" fill="black" stroke="red"/>
        <xsl:apply-templates select="//price"/>
    </xsl:template>


    <xsl:template match="price">
        <rect x="{10*position()}" y="{100- .}" width="10"
              height="{.}" fill="red" stroke="black"/>
    </xsl:template>
-->

</xsl:stylesheet>