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
                <div id="content">
                    <!-- imports the elements from another xml to be searched-->
                    <div>
                        <h2> Willkommen im Adminbereich </h2>
                    </div>
                    <div id="tabs" class="tabs">
                        <ul>
                            <li><a href="#tabs-1">Räume hinzufügen</a></li>
                            <li><a href="#tabs-2">Angebote hinzufügen</a></li>
                            <li><a href="#tabs-3">Räume verwalten</a></li>
                            <li><a href="#tabs-4">Angebote verwalten</a></li>
                        </ul>
                        <div id="tabs-1">
                            <form method="post">
                                <table class="newRoomTable">
                                    <tr>
                                        <td class="eventLeftColumn">Raumname</td>
                                        <td>
                                            <input type="text" name="add_roomname" id="add_roomname" autofocus="autofocus" size="30" required="required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Preis</td>
                                        <td>
                                            <input type="text" name="add_roomprice" id="add_roomprice" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Anz. Betten</td>
                                        <td>
                                            <input type="text" name="add_roombeds" id="add_roombeds" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Bild</td>
                                        <td>
                                            <input type="text" name="add_roomimage" id="add_roomimage" size="30" required="required"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Beschreibung</td>
                                        <td>
                                            <textarea name="add_roombed" id="add_roomdescription" cols="24"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  colspan="2">
                                            <input type="button" id="addroom" href="#" value="Hinzufügen"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <br/>
                                    </tr>
                                </table>
                            </form>
                            <div style="clear: both;"></div>
                        </div>
                        <div id="tabs-2">
                            <form method="post">
                                <table class="newActivityTable">
                                    <tr>
                                        <td class="eventLeftColumn">Eventname</td>
                                        <td>
                                            <input type="text" name="add_eventtitle" id="add_eventtitle" autofocus="autofocus" size="30" required="required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Ersteller</td>
                                        <td>
                                            <input type="text" name="add_eventprovider" id="add_eventprovider" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Durchführungsdatum</td>
                                        <td>
                                            <input type="date" name="add_eventactivitydate" id="add_eventactivitydate" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Beschreibung</td>
                                        <td>
                                            <textarea name="add_eventdescription" id="add_eventdescription" cols="24"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Bild</td>
                                        <td>
                                            <input type="url" name="add_eventimage" id="add_eventimage" size="30" placeholder="http://www.yourEvent/image.jpg" required="required"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Kontakt Telefonnummer</td>
                                        <td>
                                            <input type="text" name="add_eventcontact_phone" id="add_eventcontact_phone" placeholder="Tel. Nr" size="5"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Kontakt E-Mail</td>
                                        <td>
                                            <input type="text" name="add_eventcontact_email" id="add_eventcontact_email" placeholder="E-Mail" size="5"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Preis</td>
                                        <td>
                                            <input type="text" name="add_eventprice" id="add_eventprice"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Anmeldedatum Start</td>
                                        <td>
                                            <input type="date" name="add_eventsignupstart" id="add_eventsignupstart" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="eventLeftColumn">Anmeldedatum Ende</td>
                                        <td>
                                            <input type="date" name="add_eventsignupend" id="add_eventsignupend" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  colspan="2">
                                            <input type="button" id="addevent" href="#" value="Hinzufügen"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <br/>
                                    </tr>
                                </table>
                            </form>
                            <div style="clear: both;"></div>
                        </div>
                        <div id="tabs-3">
                            <xsl:apply-templates select="document('../data/roomdb.xml')/hostelrooms"/>
                            <div style="clear: both;"></div>
                            <div id="deleteroomdialog" class="dialog" title="Raum löschen" style="display:none;">
                                Sind Sie sich sicher, dass Sie den Raum entfernen möchten?
                            </div>
                            <div id="editroomdialog" class="dialog" title="Raum ändern" style="display:none;">
                                <form method="post">
                                    <table class="newRoomTable">
                                        <tr>
                                            <td class="eventLeftColumn">Raumname</td>
                                            <td>
                                                <input type="text" name="edit_roomname" id="edit_roomname" autofocus="autofocus" size="30" required="required" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Preis</td>
                                            <td>
                                                <input type="text" name="edit_roomprice" id="edit_roomprice" size="30"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Anz. Betten</td>
                                            <td>
                                                <input type="text" name="edit_roombeds" id="edit_roombeds" size="30"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Bild</td>
                                            <td>
                                                <input type="text" name="edit_roomimage" id="edit_roomimage" size="30" required="required"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Beschreibung</td>
                                            <td>
                                                <textarea name="edit_roombed" id="edit_roomdescription" cols="24"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <br/>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div id="tabs-4">
                            <xsl:apply-templates select="document('../data/activitydb.xml')/activities"/>
                            <div style="clear: both;"></div>
                            <div id="deleteeventdialog" class="dialog" title="Angebot löschen" style="display:none;">
                                Sind Sie sich sicher, dass Sie dieses Angebot entfernen möchten?
                            </div>
                            <div id="editeventdialog" class="dialog" title="Angebot ändern" style="display:none;">
                                <form class="newEventForm" method="post">
                                    <table class="newEventTable">
                                        <tr>
                                            <td class="eventLeftColumn">Eventname</td>
                                            <td>
                                                <input type="text" name="edit_eventtitle" id="edit_eventtitle" autofocus="autofocus" size="30" required="required" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Ersteller</td>
                                            <td>
                                                <input type="text" name="edit_eventprovider" id="edit_eventprovider" size="30"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Durchführungsdatum</td>
                                            <td>
                                                <input type="date" name="edit_eventactivitydate" id="edit_eventactivitydate" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Beschreibung</td>
                                            <td>
                                                <textarea name="edit_eventdescription" id="edit_eventdescription" cols="24"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Bild</td>
                                            <td>
                                                <input type="url" name="edit_eventimage" id="edit_eventimage" size="30" placeholder="http://www.yourEvent/image.jpg" required="required"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Kontakt Telefonnummer</td>
                                            <td>
                                                <input type="text" name="edit_eventcontact_phone" id="edit_eventcontact_phone" placeholder="Tel. Nr" size="5"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Kontakt E-Mail</td>
                                            <td>
                                                <input type="text" name="edit_eventcontact_email" id="edit_eventcontact_email" placeholder="E-Mail" size="5"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Preis</td>
                                            <td>
                                                <input type="text" name="edit_eventprice" id="edit_eventprice"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Anmeldedatum Start</td>
                                            <td>
                                                <input type="date" name="edit_eventsignupstart" id="edit_eventsignupstart" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="eventLeftColumn">Anmeldedatum Ende</td>
                                            <td>
                                                <input type="date" name="edit_eventsignupend" id="edit_eventsignupend" placeholder="dd.MM.yyyy" size="9" class="datepicker"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <br/>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div style="clear:both;"></div>
                    <br/>
                    <button type="button" id="navLink1" href="#" onclick="logout();">Log out</button>
                </div>
                <div style="clear:both;"></div>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="room">
        <div class="item adminroomitem">
            <xsl:call-template name="rooms"/>
        </div>
    </xsl:template>

    <xsl:template name="rooms">
        <div>
            <div class="itemvaluename roomImage roomitemimage" style="background-image:url({image})">
                <button class="editButton editroom" title="Editieren"></button>
                <button class="deleteButton deleteroom" title="Löschen"></button>
                <button class="showbookingButton showbooking" title="Buchungen"></button>
            </div>
        </div>

        <center><h2><div class="itemvaluename roomitemname"><xsl:value-of select="./@name"/></div></h2></center>

        <table id="{./@ID}" class="roomitemTable">
            <tr>
                <td class="itemvaluename"><b>Preis</b></td><td><xsl:value-of select="price/@currency"/>: <div class="roomitemprice"><xsl:apply-templates select="price"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Anz. Betten</b></td><td><div class="roomitembeds"><xsl:apply-templates select="beds"/></div></td>
            </tr>
            <tr>
                <td class="itemvaluename"><b>Beschreibung</b></td><td><div class="roomitemdescription"><xsl:apply-templates select="description"/></div></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="showbookingsdialog" title="Zimmerbuchungen Zimmer {./@name}" class="bookingsdialog" roomid="{./@ID}" style="display:none;">
                        <xsl:apply-templates select="bookings"/>
                    </div>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="booking">
        <xsl:call-template name="booking"/>
    </xsl:template>

    <xsl:template name="booking">
        <table id="{./@ID}">
            <tr>
                <td class="eventLeftColumn">Anmeldedatum Start</td>
                <td>
                    <xsl:value-of select="startdate"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Anmeldedatum Ende</td>
                <td>
                    <xsl:value-of select="enddate"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">E-Mail</td>
                <td>
                    <xsl:value-of select="email"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Preis</td>
                <td>
                    <xsl:value-of select="paidprice"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Anrede</td>
                <td>
                    <xsl:value-of select="bookingaddress/salutation"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Vorname</td>
                <td>
                    <xsl:value-of select="bookingaddress/firstname"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Nachname</td>
                <td>
                    <xsl:value-of select="bookingaddress/lastname"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Addresse</td>
                <td>
                    <xsl:value-of select="bookingaddress/address"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">PLZ</td>
                <td>
                    <xsl:value-of select="bookingaddress/zipcode"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Ort</td>
                <td>
                    <xsl:value-of select="bookingaddress/state"/>
                </td>
            </tr>
            <tr>
                <td class="eventLeftColumn">Land</td>
                <td>
                    <xsl:value-of select="bookingaddress/country"/>
                </td>
            </tr>
            <tr>
                <br/>
            </tr>
        </table>
        <hr/>
    </xsl:template>

    <xsl:template match="activity">
        <div class="item adminactivityitem">
            <xsl:call-template name="activities"/>
        </div>
    </xsl:template>

    <xsl:template name="activities">
        <div>
            <div class="itemvaluename activityImage eventitemimage" style="background-image:url({image})">
                <button class="editButton editevent" title="Editieren"></button>
                <button class="deleteButton deleteevent" title="Löschen"></button>
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