<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
				
				<xsl:template match="/">
								<fo:root>
												<fo:layout-master-set>
																<fo:simple-page-master master-name="event_list" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
																				<fo:region-body margin-top="1cm"/>
																				<fo:region-before extent="2cm"/>
																				<fo:region-after extent="3cm"/>
																</fo:simple-page-master>
												</fo:layout-master-set>
												<fo:page-sequence master-reference="event_list">
																<fo:static-content flow-name="xsl-region-before">
																				<fo:block text-align="center" font-size="8pt">
																								Buchungsbestätigung  /  Seite
																								<fo:page-number/>
																				</fo:block>
																</fo:static-content>
																<fo:flow flow-name="xsl-region-body">
																				
																				<fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt" background-color="red" color="white" text-align="center" padding-top="5pt" padding-bottom="5pt">Buchungsbestätigung Alperlebnis+</fo:block>
																				<xsl:apply-templates />
																</fo:flow>
												</fo:page-sequence>
								</fo:root>
				</xsl:template>
				
				<xsl:template match="booking">
								<fo:table space-after.optimum="20pt" width="13cm" font-size="11pt">
												<fo:table-column column-number="1"/>
												<fo:table-column column-number="2"/>
												<fo:table-column column-number="3"/>
												<fo:table-body>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block padding-top="2pt">
																												Sehr geehrte/r <xsl:value-of select="bookingaddress/salutation"/>&#160;<xsl:value-of select="bookingaddress/lastname"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>																
																				<fo:table-cell padding-top="2pt" number-columns-spanned="2">
																								<fo:block padding-top="2pt">
																												Vielen Dank für die Buchung bei Alperlebnis+. 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell padding-top="2pt" number-columns-spanned="3">
																								<fo:block padding-top="2pt">
																												Nachfolgend finden Sie Ihre Buchungsbestätigung. Sollten Sie Fragen haben, können Sie sich gerne mit uns in Verbindung setzten. 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell padding-top="3pt" number-columns-spanned="2">
																								<fo:block padding-top="2pt">
																												Wir wünschen Ihnen einen angenehmen Aufenthalt. 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell padding-top="8pt" number-columns-spanned="2">
																								<fo:block padding-top="2pt">
																												Ihr Alplerlebnis+ Team 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell padding-top="30pt" number-columns-spanned="2">
																								<fo:block font-size="14pt" color="red" font-weight="900" text-align="left">
																												Raumname: <xsl:value-of select="roomname"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
                                                                                <fo:table-cell  padding-top="2pt" number-columns-spanned="1">
																								<fo:block>
																												Anreisedatum: <xsl:value-of select="startdate"/>
																								</fo:block>
																				</fo:table-cell>
                                                                </fo:table-row>
                                                                
                                                                <fo:table-row>
																				<fo:table-cell padding-top="4pt" number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Abreisedatum: <xsl:value-of select="enddate"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Email: <xsl:value-of select="email"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Preis: <xsl:value-of select="paidprice"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell padding-top="7pt" number-columns-spanned="2" padding-bottom="1pt">
																								<fo:block>
																												Buchungsadresse: 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Anrede: <xsl:value-of select="bookingaddress/salutation"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Vorname: <xsl:value-of select="bookingaddress/firstname"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Nachname: <xsl:value-of select="bookingaddress/lastname"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Strasse: <xsl:value-of select="bookingaddress/address"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												PLZ: <xsl:value-of select="bookingaddress/zipcode"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Ort: <xsl:value-of select="bookingaddress/state"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Land: <xsl:value-of select="bookingaddress/country"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
												</fo:table-body>
								</fo:table>	
				</xsl:template>
</xsl:stylesheet>
