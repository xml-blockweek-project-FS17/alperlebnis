<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://snolicio.us"
                xmlns:svg="http://www.w3.org/2000/svg"
                        xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml"
                >
 
  <xsl:import href="navigation.xsl"/>
 
  <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
 
 
  <xsl:template match="/">
    <html lang="de">
      <xsl:call-template name="meta">
        <xsl:with-param name="pageName">Angebotsverwaltung</xsl:with-param>
      </xsl:call-template>
 
      <body>
        <xsl:call-template name="header">
          <xsl:with-param name="pageName">Angebotsverwaltung</xsl:with-param>
        </xsl:call-template>
 
 
        <h1>Create a new event</h1>
        <hr/>
        <form class="newEventForm" action="newEvent.php" method="post">
          <table class="newEventTable">
            <tr>
              <td class="eventLeftColumn">Title</td>
              <td>
                <input type="text" name="title"  autofocus="autofocus" size="30" required="required" />
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Creator</td>
              <td>
                <input type="text" name="creator" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Contact</td>
              <td>
                <input type="text" name="contact" placeholder="E-Mail or Tel. Nr" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Description</td>
              <td>
                <textarea name="description" cols="24"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Location</td>
              <td>
                <input type="text" name="location" size="30" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Max. persons</td>
              <td>
                <input type="text" name="maxReservations" size="5"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Price per Person </td>
              <td>
                <input type="text" name="price" size="5"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Date</td>
              <td>
                <input type="text" name="date" placeholder="dd.MM.yyyy" size="9" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Time</td>
              <td>
                <input type="time" name="time" placeholder="hh:mm" size="9" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Event-picture</td>
              <td>
                <input type="url" name="image" placeholder="http://www.yourEvent/image.jpg" size="30"/>
              </td>
            </tr>
            <tr>
              <td  colspan="2">
                <input type="submit" value="Create"/>
              </td>
            </tr>
            <tr>
              <br/>
            </tr>
          </table>
        </form>
        <xsl:call-template name="footer"/>
 
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>