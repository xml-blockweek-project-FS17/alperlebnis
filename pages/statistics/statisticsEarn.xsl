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

    <xsl:variable name="total" select="sum(//booking[number(translate(startdate, '-', '')) &gt;= $fromDateNum and number(translate(enddate, '-', '')) &lt;= $toDateNum]/paidprice)" />
    <xsl:variable name="maxCost" select="number(//room/price[not(. &lt; //room/price)][1])" />

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

        <div class="chartHeader" style="width:{$chartWidth}px;">Preisübersicht der Räume</div>

        <div class="barchart" style="width: {$chartWidth}px; height: {$chartHeight}px;">

            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 9"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 8"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 7"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 6"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 5"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 4"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 3"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10 * 2"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="$maxCost div 10"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="bar">
                <div class="value"><div><xsl:value-of select="0"/></div></div>
                <div class="line" style="width: {$lineWidth}px;"></div>
            </div>
            <div class="blockWrapper">
                <xsl:for-each select="//room">
                    <div class="blockItem" style="margin-left: {80 * (position() - 1)}px">
                        <xsl:value-of select="price"/>
                        <div class="block" style="height: {(number(price) div $maxCost)*($viewHeight)}px;"></div>
                        <div class="label">
                            <xsl:value-of select="./@name"/>
                        </div>
                    </div>
                </xsl:for-each>

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