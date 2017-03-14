<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:import href="navigation.xsl"/>
  
  <!--Message should only be set over XSLTProcess->setParameter() but needs a placeholder to work properly-->
  <xsl:param name="message" select="''"/>
  
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
        
        <div class="message">
          <xsl:if test="string($message)">
            <xsl:value-of select="$message"/>
          </xsl:if>
        </div>
        <!-- imports the elements from another xml to be searched-->
        <xsl:apply-templates select="document('../data/activitydb.xml')/activities"/>
        
        <form class="newActivityForm" action="../php/newActivity.php" method="post">
          <h2>Neue Aktivität erstellen</h2>
          
          
          
          <hr/>
          <table class="newEventTable">
            <tr>
              <td class="eventLeftColumn">Titel</td>
              <td>
                <input type="text" name="title" size="30" required="required" />
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anbieter</td>
              <td>
                <input type="text" name="creator" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Preis</td>
              <td>
                <input type="number" name="price" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Durchführungsdatum</td>
              <td>
                <input type="text" name="date" placeholder="DD.MM.YYYY" size="9" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anmeldestart</td>
              <td>
                <input type="text" name="startregister" placeholder="DD.MM.YYYY" size="9" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anmeldeschluss</td>
              <td>
                <input type="text" name="endregister" placeholder="DD.MM.YYYY" size="9" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Telefon</td>
              <td>
                <input type="text" name="telephone" placeholder="Telefon-Nummer" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Email</td>
              <td>
                <input type="text" name="email" placeholder="Email-Adresse" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Beschreibung</td>
              <td>
                <textarea name="description" cols="24" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Aktivitätsbild</td>
              <td>
                <input type="url" name="image" placeholder="http://www.yourEvent/image.jpg" size="30" required="required"/>
              </td>
            </tr>
            <tr>
              <td  colspan="2">
                <input type="submit" value="Erstellen"/>
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
  <!-- include basically copies the text of the other xsl-file at the position. This is why it has to be at this place (after the match for root)-->
   <xsl:include href="activity.xsl"/>
</xsl:stylesheet>