<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:php="http://php.net/xsl"
                xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:import href="navigation.xsl"/>
  
  <!--Param should only be set over XSLTProcess->setParameter() but needs a placeholder to work properly-->
  <xsl:param name="message" select="''"/>
  <xsl:param name="submit_button" select="'Erstellen'"/>
  <xsl:param name="param_title" select="''"/>
  <xsl:param name="param_provider" select="''"/>
  <xsl:param name="param_activitydate" select="''"/>
  <xsl:param name="param_desc" select="''"/>
  <xsl:param name="param_image" select="''"/>
  <xsl:param name="param_phone" select="''"/>
  <xsl:param name="param_email" select="''"/>
  <xsl:param name="param_price" select="''"/>
  <xsl:param name="param_start" select="''"/>
  <xsl:param name="param_end" select="''"/>
  <xsl:param name="param_id" select="''"/>
  <xsl:param name="form_action" select="'../php/newActivity.php'"/>
  
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
        
        <form class="newActivityForm" action="{$form_action}" method="post">
          <h2>Neue Aktivität erstellen</h2>
          <input type="hidden" name="id" value="{$param_id}"/>
          
          
          <hr/>
          <table class="newEventTable">
            <tr>
              <td class="eventLeftColumn">Titel</td>
              <td>
                <input type="text" name="title" size="30" required="required" value="{$param_title}" />
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anbieter</td>
              <td>
                <input type="text" name="creator" size="30" value="{$param_provider}"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Preis</td>
              <td>
                <input type="number" name="price" size="30" value="{$param_price}"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Durchführungsdatum</td>
              <td>
                <input type="text" name="date" placeholder="DD.MM.YYYY" size="9" value="{$param_activitydate}" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anmeldestart</td>
              <td>
                <input type="text" name="startregister" placeholder="DD.MM.YYYY" size="9" value="{$param_start}" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Anmeldeschluss</td>
              <td>
                <input type="text" name="endregister" placeholder="DD.MM.YYYY" size="9" value="{$param_end}" required="required"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Telefon</td>
              <td>
                <input type="text" name="telephone" placeholder="Telefon-Nummer" value="{$param_phone}" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Email</td>
              <td>
                <input type="text" name="email" placeholder="Email-Adresse" value="{$param_email}" size="30"/>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Beschreibung</td>
              <td>
                <textarea name="description" cols="24" required="required"><xsl:value-of select="$param_desc"/></textarea>
              </td>
            </tr>
            <tr>
              <td class="eventLeftColumn">Aktivitätsbild</td>
              <td>
                <input type="url" name="image" placeholder="http://www.yourEvent/image.jpg" value="{$param_image}" size="30" required="required"/>
              </td>
            </tr>
            <tr>
              <td  colspan="2">
                
                <input type="submit" value="{$submit_button}"/>
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