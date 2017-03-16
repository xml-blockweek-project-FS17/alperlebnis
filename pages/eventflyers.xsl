<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="date">
				
				<xsl:template match="activities">
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
																								Alperlebnis+ Eventangebote  /  Seite
																								<fo:page-number/>
																				</fo:block>
																</fo:static-content>
																<fo:flow flow-name="xsl-region-body">
																				<fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt" background-color="red" color="white" text-align="center" padding-top="5pt" padding-bottom="5pt">Alperlebnis+ Eventangebote</fo:block>
																				
																				<xsl:apply-templates />
																</fo:flow>
												</fo:page-sequence>
								</fo:root>
				</xsl:template>
				
				<xsl:template match="activity">
                                    <xsl:variable name="today" select="translate(substring-before(date:date-time(), 'T'), '-', '')"/>
                                    <xsl:variable name="start" select="translate(signupstart, '-', '')"/>
                                    <xsl:variable name="end" select="translate(signupend, '-', '')"/>
                                        <xsl:if test="$start &lt;= $today and $today &lt;= $end">
								<fo:table space-after.optimum="20pt" width="13cm" font-size="11pt">
												<fo:table-column column-number="1"/>
												<fo:table-column column-number="2"/>
												<fo:table-column column-number="3"/>
												<fo:table-body>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block font-size="14pt" color="red" font-weight="900" text-align="left">
																												<xsl:value-of select="title"/>
																								</fo:block>
																				</fo:table-cell>
																				<fo:table-cell number-rows-spanned="10">
																								<fo:block>
																												<fo:external-graphic src="{image}" content-height="scale-to-fit" height="2.5in"  content-width="2.5in" scaling="non-uniform"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
                                                                                <fo:table-cell  padding-top="2pt" number-columns-spanned="1">
																								<fo:block>
																												<xsl:value-of select="description"/>
																								</fo:block>
																				</fo:table-cell>
                                                                </fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell padding-top="4pt" number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Veranstalter: <xsl:value-of select="provider"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Veranstaltungsdatum: <xsl:value-of select="activitydate"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell padding-top="3pt" number-columns-spanned="2" padding-bottom="1pt">
																								<fo:block>
																												Anmeldungszeitraum 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												<xsl:value-of select="signupstart"/> bis <xsl:value-of select="signupend"/> 
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
																<fo:table-row>
																				<fo:table-cell padding-top="6pt" number-columns-spanned="2" padding-bottom="1pt">
																								<fo:block>
																												Anmeldung per:
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												Telefon: <xsl:value-of select="contact/phone"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                               <fo:table-row>
																				<fo:table-cell number-columns-spanned="2">
																								<fo:block>
																												E-Mail: <xsl:value-of select="contact/email"/>
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
                                                                <fo:table-row>
																				<fo:table-cell padding-top="7pt" number-columns-spanned="2" padding-bottom="4pt">
																								<fo:block>
																												Preis: <xsl:value-of select="price"/> Fr.
																								</fo:block>
																				</fo:table-cell>
																</fo:table-row>
												</fo:table-body>
								</fo:table>	
                                        </xsl:if>
				</xsl:template>
</xsl:stylesheet>
